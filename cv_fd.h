#ifndef APP_SCENARIO_APP_TFLM_FD_1MB_CV_FD_H_
#define APP_SCENARIO_APP_TFLM_FD_1MB_CV_FD_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int tflite_init();
int cv_fd_init();
int cv_fd_run(uint32_t jpeg_address, uint32_t jpeg_size, uint32_t raw_address, uint32_t raw_channels, uint32_t raw_height, uint32_t raw_size, uint32_t raw_width);

#ifdef __cplusplus
}
#endif

#endif