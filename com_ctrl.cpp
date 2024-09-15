#include "com_ctrl.h"

#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "hx_drv_uart.h"
#include "dev_common.h"

#include "xprintf.h"

int32_t uart1_send(uint8_t *data) {
    uint32_t data_len = strlen((char *)data);
    if (NULL == data || 0 == data_len) {
        return 1;
    }
    DEV_UART_PTR dev_uart1;
    dev_uart1 = hx_drv_uart_get_dev(USE_DW_UART_0);
    dev_uart1->uart_open(UART_BAUDRATE_921600);
    uint32_t sent_bytes = 0;
    do {
        int32_t send_result = dev_uart1->uart_write(data + sent_bytes, data_len - sent_bytes);
        switch (send_result)
        {
        case E_OBJ:
        case E_PAR:
        case E_SYS:
            break;
        
        default:
            sent_bytes += send_result;
            break;
        }
    }
    while (sent_bytes < data_len);
    dev_uart1->uart_close();
    return 0;
}

int32_t base64_encode_get_buffer_len(uint32_t data_len) {
    return (data_len + 2) / 3 * 4 + 1;
}

int32_t base64_encode(uint8_t *data, uint32_t data_len, uint8_t *encoded_data) {
    static const uint8_t base64_table[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    uint8_t array_8bit[3];
    uint8_t array_6bit[4];
    
    int32_t current_data_len = data_len;

    while(0 < current_data_len) {
        for (uint32_t i = 0; i < 3; i++) {
            if (0 < current_data_len) {
                array_8bit[i] = *(data++);
            }
            else {
                array_8bit[i] = '\0';
            }
            current_data_len--;
        }
        array_6bit[0] = array_8bit[0] >> 2;
        array_6bit[1] = ((array_8bit[0] << 4) & 0x3F) | (array_8bit[1] >> 4);
        array_6bit[2] = ((array_8bit[1] << 2) & 0x3F) | (array_8bit[2] >> 6);
        array_6bit[3] = array_8bit[2] & 0x3F;
        for (uint32_t i = 0; i < 4; i++) {
            *encoded_data++ = base64_table[array_6bit[i]];
        }
    }
    while (0 > current_data_len) {
        *encoded_data++ = '=';
        current_data_len++;
    }
    *encoded_data = '\0';
    return 0;
}