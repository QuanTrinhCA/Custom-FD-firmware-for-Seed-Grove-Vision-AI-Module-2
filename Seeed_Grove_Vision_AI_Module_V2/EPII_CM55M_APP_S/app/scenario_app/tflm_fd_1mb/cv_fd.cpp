#include "cv_fd.h"
#include "memory_manage.h"

#include <stdint.h>

//#include "tensorflow/lite/c/common.h"
//#include "tensorflow/lite/schema/schema_generated.h"
//#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
//#include "tensorflow/lite/micro/micro_interpreter.h"
//#include "tensorflow/lite/micro/micro_error_reporter.h"

#include "tensorflow/lite/micro/micro_mutable_op_resolver.h"
//#include "tensorflow/lite/micro/tflite_bridge/micro_error_reporter.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"

#include "WE2_core.h"

#include "ethosu_driver.h"

#include "cisdp_sensor.h"
#include "sensor_dp_lib.h"
#include "img_proc_helium.h"

#include "xprintf.h"


#define TENSOR_ARENA_SIZE           (1484 * 1024)
#define FD_INPUT_TENSOR_WIDTH   	(320)
#define FD_INPUT_TENSOR_HEIGHT      (240)

//static ethosu_driver ethosu_drv;
//static tflite::MicroErrorReporter error_reporter;
static tflite::MicroInterpreter *interpreter_ptr;
static tflite::MicroMutableOpResolver<1U> op_resolver;
static uint8_t *tensor_arena;

int tflite_init() {
    //error_reporter = tflite::MicroErrorReporter();

    tensor_arena = (uint8_t *)mm_reserve(TENSOR_ARENA_SIZE);

    static const tflite::Model *model = tflite::GetModel((const void *)(BASE_ADDR_FLASH1_R_ALIAS+0x200000));
   
    if (model->version() != TFLITE_SCHEMA_VERSION)
    {
        xprintf("Model provided is schema version %d, but required version is %d\n",
                model->version(), TFLITE_SCHEMA_VERSION);
        return -1;
    } else {
        xprintf("Model is schema version %d\n", model->version());
    }
    
    if (kTfLiteOk != op_resolver.AddEthosU())
    {
        xprintf("Failed to add EthosU op resolver\n");
        return -1;
    }

    static tflite::MicroInterpreter interpreter(model, 
                                                op_resolver,
                                                tensor_arena,
                                                TENSOR_ARENA_SIZE);
    interpreter.AllocateTensors();
    interpreter_ptr = &interpreter;
    xprintf("TFLM initialised\n");
    return 0;
}

float_t range_scale(float_t in_min, float_t in_max, float_t out_min, float_t out_max, float_t x) {
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

int cv_fd_init() {

    if (0 != tflite_init())
    {
        xprintf("failed to initialise TFLite interpreter\n");
        return -1;
    }
    return 0;
}

int cv_fd_run(uint32_t jpeg_address, uint32_t jpeg_size, uint32_t raw_address, uint32_t raw_channels, uint32_t raw_height, uint32_t raw_size, uint32_t raw_width) {
    float w_scale = (float)(raw_width - 1) / (FD_INPUT_TENSOR_WIDTH - 1);
    float h_scale = (float)(raw_height - 1) / (FD_INPUT_TENSOR_HEIGHT - 1);
    SCB_InvalidateDCache_by_Addr((void *)raw_address, raw_size);

    //uint8_t * resized_img = (uint8_t *)mm_reserve(FD_INPUT_TENSOR_WIDTH * FD_INPUT_TENSOR_HEIGHT * 3);
    hx_lib_image_resize_BGR8U3C_to_RGB24_helium((uint8_t *)raw_address, (uint8_t *)interpreter_ptr->input(0)->data.uint8, raw_width, raw_height, 3, FD_INPUT_TENSOR_WIDTH, FD_INPUT_TENSOR_HEIGHT, w_scale, h_scale);
    /*
    float_t * scaled_img = (float_t *)mm_reserve(FD_INPUT_TENSOR_WIDTH * FD_INPUT_TENSOR_HEIGHT * 3 * sizeof(float_t));
    for (uint8_t h = 0; h < FD_INPUT_TENSOR_HEIGHT; h++) {
        for (uint8_t w = 0; w < FD_INPUT_TENSOR_WIDTH; w++) {
            for (uint8_t c = 0; c < 3; c++) {
                uint8_t i = (h * FD_INPUT_TENSOR_WIDTH + w) * 3 + c;
                scaled_img[i] = range_scale(0, 255, -1, 1, resized_img[i]);
            }
        }
    }*/
    // = scaled_img;
    if (kTfLiteOk != interpreter_ptr->Invoke())
    {
        xprintf("Failed to invoke interpreter\n");
        return -1;
    }

    for (uint8_t i = 0; i < 5; i++) {
        xprintf("%f ", interpreter_ptr->output(0)->data.f[i]);
    }
    xprintf("\n");
    sensordplib_retrigger_capture();
    return 0;
}