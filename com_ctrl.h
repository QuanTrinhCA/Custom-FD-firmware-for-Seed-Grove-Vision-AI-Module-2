#ifndef APP_SCENARIO_APP_TFLM_FD_1MB_COM_CTRL_H_
#define APP_SCENARIO_APP_TFLM_FD_1MB_COM_CTRL_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int32_t uart1_send(uint8_t *data);
int32_t base64_encode_get_buffer_len(uint32_t data_len);
int32_t base64_encode(uint8_t *data, uint32_t data_len, uint8_t *encoded_data);

#ifdef __cplusplus
}
#endif

#endif