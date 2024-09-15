#include "tflm_fd_1mb.h"
#include "cv_fd.h"
#include "com_ctrl.h"
#include "memory_manage.h"

#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "cisdp_sensor.h"

#include "event_handler.h"
#include "event_handler_evt.h"
#include "event_handler_cfg.h"

#include "hx_drv_uart.h"
#include "hx_drv_scu.h"
#include "hx_drv_watchdog.h"
#include "hx_drv_pmu.h"
#include "hx_drv_pmu_export.h"

#include "powermode.h"
#include "powermode_export.h"

#include "spi_master_protocol.h"
#include "hx_drv_spi.h"
#include "spi_eeprom_comm.h"


#include "ethosu_driver.h"

#include "sensor_dp_lib.h"

#include "xprintf.h"

#define WATCHDOG_PERIOD	(500) //ms

static struct ethosu_driver ethosu_drv; /* Default Ethos-U device driver */
static uint8_t * resized_img;

void wdg_isr_cb(event) {
    xprintf("Watchdog timeout\n");
    xprintf("Watchdog value: %d\n", hx_drv_watchdog_value(WATCHDOG_ID_0));
    xprintf("wdg_isr_cb event: %d\n", event);
    return;
}
            

void evt_handler_db_cb(EVT_INDEX_E event) {
    switch (event) {
        case EVT_INDEX_XDMA_FRAME_READY:
            xprintf("Frame ready\n");
            //hx_drv_watchdog_update(WATCHDOG_ID_0, WATCHDOG_PERIOD); //Update Watchdog
            //xprintf("Watchdog updated\n");
            //Run CV
            
            cv_fd_run(
                app_get_jpeg_addr(), 
                app_get_jpeg_sz(),
                app_get_raw_addr(),
                app_get_raw_channels(),
                app_get_raw_height(),
                app_get_raw_sz(),
                app_get_raw_width()
            );
            break;
        case EVT_INDEX_CDM_MOTION:
            //do nothing at this moment
            xprintf("CDM\n");
            break;
        case EVT_INDEX_SENSOR_RTC_FIRE:
        case EVT_INDEX_1BITPARSER_ERR:
            hx_drv_inp1bitparser_clear_int();
		    hx_drv_inp1bitparser_set_enable(0);
        case EVT_INDEX_CDM_FIFO_ERR:
        case EVT_INDEX_XDMA_WDMA1_ABNORMAL:
        case EVT_INDEX_XDMA_WDMA2_ABNORMAL:
        case EVT_INDEX_XDMA_WDMA3_ABNORMAL:
        case EVT_INDEX_XDMA_RDMA_ABNORMAL:
        case EVT_INDEX_EDM_WDT1_TIMEOUT:
        case EVT_INDEX_EDM_WDT2_TIMEOUT:
        case EVT_INDEX_EDM_WDT3_TIMEOUT:        
        case EVT_INDEX_HXAUTOI2C_ERR:
        default:
            cisdp_sensor_stop();
            xprintf("Error\n");
            break;  
    }
}

int gpio_spi_pinmux_cfg(SCU_PINMUX_CFG_T *pinmux_cfg) {
    pinmux_cfg->pin_pb2 = SCU_PB2_PINMUX_SPI_M_DO_1;        /*!< pin PB2*/
	pinmux_cfg->pin_pb3 = SCU_PB3_PINMUX_SPI_M_DI_1;        /*!< pin PB3*/
	pinmux_cfg->pin_pb4 = SCU_PB4_PINMUX_SPI_M_SCLK_1;      /*!< pin PB4*/
	pinmux_cfg->pin_pb11 = SCU_PB11_PINMUX_SPI_M_CS;        /*!< pin PB11*/
    return 0;
}

int gpio_uart_pinmux_cfg(SCU_PINMUX_CFG_T *pinmux_cfg) {
    pinmux_cfg->pin_pb6 = SCU_PB6_PINMUX_UART1_RX;
    pinmux_cfg->pin_pb7 = SCU_PB7_PINMUX_UART1_TX;
    return 0;
}

int pinmux_init() {
    SCU_PINMUX_CFG_T *pinmux_cfg;
    hx_drv_scu_get_all_pinmux_cfg(pinmux_cfg);
    gpio_spi_pinmux_cfg(pinmux_cfg);
    gpio_uart_pinmux_cfg(pinmux_cfg);
    hx_drv_scu_set_all_pinmux_cfg(pinmux_cfg, 1);
    return 0;
}

int cisdp_init() {
    if (0 != cisdp_sensor_init()) {
        xprintf("cisdp_sensor_init failed\n");
        return -1;
    };
    if (0 != cisdp_dp_init(true, SENSORDPLIB_PATH_INT_INP_HW5X5_JPEG, evt_handler_db_cb, 4, APP_DP_RES_RGB640x480_INP_SUBSAMPLE_2X)) {
        xprintf("cisdp_dp_init failed\n");
        return -1;
    } 
    return 0;
}

int watchdog_start() {
	//watch dog start
    #ifdef WDG_CPU
	WATCHDOG_CFG_T wdg_cfg;
	wdg_cfg.period = WATCHDOG_PERIOD;
	wdg_cfg.ctrl = WATCHDOG_CTRL_CPU;
	wdg_cfg.state = WATCHDOG_STATE_DC;
	wdg_cfg.type = WATCHDOG_RESET;
	if (0 != hx_drv_watchdog_start(WATCHDOG_ID_0, &wdg_cfg, wdg_isr_cb)) {
        xprintf("Watchdog start failed\n");
        return -1;
    };
    #else
    if (0 != hx_drv_pmu_wdt_start(PMU_TIMEOUT_WDT, WATCHDOG_PERIOD, 1, wdg_isr_cb, 1)) {
        xprintf("Watchdog start failed\n");
        return -1;
    };
    #endif
    return 0;
}

int print_hardware_info() {
    uint32_t hsc_clk, lsc_clk; 
    hx_drv_scu_get_freq(SCU_CLK_FREQ_TYPE_HSC_CM55M, &hsc_clk);
	hx_drv_scu_get_freq(SCU_CLK_FREQ_TYPE_LSC_CM55S, &lsc_clk);
    xprintf("Hardware Info:\n");
    xprintf("**************************************\n");
    xprintf("HSC (Big Core) Clock: %d\n",hsc_clk);
    xprintf("LSC (Small Core) Clock: %d\n",lsc_clk);
}

int print_pmu_info() {
    PMU_PS_STATE_E ps_state;
    PM_CFG_PWR_MODE_E cfg_pwr_mode;

    hx_lib_pm_state_get(&ps_state);
    hx_lib_pm_mode_get(&cfg_pwr_mode);

    xprintf("PMU Info:\n");
    xprintf("**************************************\n");
    switch (ps_state)
    {
    case PMU_PS_STATE_DPD:
        xprintf("Power State: PMU_PS_STATE_DPD\n");
        break;
    
    case PMU_PS_STATE_PD:
        xprintf("Power State: PMU_PS_STATE_PD\n");
        break;

    case PMU_PS_STATE_SCL:
        xprintf("Power State: PMU_PS_STATE_SCL\n");
        break;

    case PMU_PS_STATE_SCH:
        xprintf("Power State: PMU_PS_STATE_SCH\n");
        break;

    case PMU_PS_STATE_DC:
        xprintf("Power State: PMU_PS_STATE_DC\n");
        break;

    default:
        break;
    }

    switch (cfg_pwr_mode)
    {
    case PM_MODE_ALL_ON:
        xprintf("Power Mode: PM_MODE_ALL_ON\n");
        break;
    case PM_MODE_PS_DPD:
        xprintf("Power Mode: PM_MODE_PS_DPD\n");
        break;
    case PM_MODE_PS_NOVID_PREROLLING:
        xprintf("Power Mode: PM_MODE_PS_NOVID_PREROLLING\n");
        break;
    case PM_MODE_PS_VID_ONLY_PREROLLING: 
        xprintf("Power Mode: PM_MODE_PS_VID_ONLY_PREROLLING\n");
        break;
    case PM_MODE_PS_AUD_ONLY_PREROLLING: 
        xprintf("Power Mode: PM_MODE_PS_AUD_ONLY_PREROLLING\n");
        break;
    case PM_MODE_PS_VIDAUD_PREROLLING: 
        xprintf("Power Mode: PM_MODE_PS_VIDAUD_PREROLLING\n");
        break;
    case PM_MODE_PS_SCL_RC9648_CPU:
        xprintf("Power Mode: PM_MODE_PS_SCL_RC9648_CPU\n");
        break;
    default:
        break;
    }
}

void arm_ethosu_u55_irq_handler(void)
{
    /* Call the default interrupt handler from the NPU driver */
    ethosu_irq_handler(&ethosu_drv);
}

static void arm_ethosu_u55_irq_init(void)
{
    const IRQn_Type ethosu_irqnum = (IRQn_Type)U55_IRQn;
    /* Register the EthosU IRQ handler in our vector table.
     * Note, this handler comes from the EthosU driver */
    NVIC_SetVector(ethosu_irqnum, (uint32_t)arm_ethosu_u55_irq_handler);
    /* Enable the IRQ */
    NVIC_EnableIRQ(ethosu_irqnum);
}

int arm_ethosu_u55_init(bool security_enable, bool privilege_enable)
{
    /* Initialize the IRQ */
    arm_ethosu_u55_irq_init();

    /* Initialize Ethos-U device */
    return ethosu_init(
        &ethosu_drv, /* Ethos-U driver device pointer */
        (void *)(U55_BASE_REG), /* Ethos-U NPU's base address. */
        NULL, /* Pointer to fast mem area - NULL for U55. */
        0, /* Fast mem region size. */
        security_enable, /* Security enable. */
        privilege_enable /* Privilege enable. */
    );
}

int print_ethosu_info() {
    struct ethosu_hw_info ethosu_hw;
    ethosu_get_hw_info(&ethosu_drv, &ethosu_hw);
    xprintf("**************************************\n");
    xprintf("Ethos-U Info:\n");
    xprintf("**************************************\n");
    xprintf("Ethos-U Product Major: %d\n", ethosu_hw.version.product_major);
    xprintf("Ethos-U Arch Rev: %d.%d.%d\n", ethosu_hw.version.arch_major_rev, ethosu_hw.version.arch_minor_rev, ethosu_hw.version.arch_patch_rev);
    xprintf("Ethos-U Version: %d.%d\n", ethosu_hw.version.version_major, ethosu_hw.version.version_minor);
    xprintf("Ethos-U Version Status: %d\n", ethosu_hw.version.version_status);
    xprintf("Ethos-U MACs per CC: %d\n", ethosu_hw.cfg.macs_per_cc);
    xprintf("Ethos-U Command Stream Version: %d\n", ethosu_hw.cfg.cmd_stream_version);
    xprintf("Ethos-U Custom DMA: %d\n", ethosu_hw.cfg.custom_dma);
    xprintf("**************************************\n");
    return 0;
}

int app_main() {
    xprintf("TFLM_TD_SGREENGOLF\n");
    //mm_set_initial(BOOT2NDLOADER_BASE, (SRAM0_SIZE + SRAM1_SIZE) -(BOOT2NDLOADER_BASE-BASE_ADDR_SRAM0_ALIAS));
    mm_init(1, (m_region_t []){{BOOT2NDLOADER_BASE, (SRAM0_SIZE + SRAM1_SIZE)-(BOOT2NDLOADER_BASE-BASE_ADDR_SRAM0_ALIAS), NULL, 0}});
    arm_ethosu_u55_init(true, true);
    //print_hardware_info();
    //print_pmu_info();
    print_ethosu_info();

    pinmux_init();

    hx_lib_spi_eeprom_open(USE_DW_SPI_MST_Q);
    hx_lib_spi_eeprom_enable_XIP(USE_DW_SPI_MST_Q, true, FLASH_QUAD, true);

    if (0 != cv_fd_init()) {
        xprintf("cv_fd_init failed\n");
        while(1){
            __NOP();
        };
    };
    //cisdp_init();
    //watchdog_start();
    //event_handler_init();
    //cisdp_sensor_start();
    //event_handler_start();
    

    // while (1)
    // {
    //     uint32_t wdg_cur_count;
    //     hx_drv_pmu_get_ctrl(PMU_pmu_wdg_cur_count, &wdg_cur_count);
    //     xprintf("Watchdog current count: %d\n", wdg_cur_count);
    //     if (wdg_cur_count < 100) {
    //         hx_drv_pmu_set_ctrl(PMU_pmu_wdg_cur_count, 16000);
    //         break;
    //     }
    // }
    return 0;
}