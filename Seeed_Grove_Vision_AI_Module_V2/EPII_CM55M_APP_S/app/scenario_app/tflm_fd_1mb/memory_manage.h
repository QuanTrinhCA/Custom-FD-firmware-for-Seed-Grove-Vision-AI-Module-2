#ifndef APP_SCENARIO_APP_TFLM_FD_1MB_MEMORY_MANAGE_H_
#define APP_SCENARIO_APP_TFLM_FD_1MB_MEMORY_MANAGE_H_
#include <stdint.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct m_alloc_t {
	void *ptr;
	uint32_t size;
} m_alloc_t;


typedef struct m_region_t {
    uint32_t start_addr;
    uint32_t end_addr;
    m_alloc_t *m_alloc_table;
    uint32_t m_alloc_table_len;
} m_region_t;

//int mm_set_initial(uint32_t start_addr, uint32_t mm_sz);
void mm_init(const uint8_t total_regions, const m_region_t * regions);
uint32_t mm_reserve(uint32_t sz);
uint32_t mm_reserve_align(uint32_t sz, uint32_t alignment_size);
void * mm_malloc(const uint32_t sz, const uint32_t alignment);
//uint32_t mm_realloc(const uint32_t ptr, const uint32_t sz);
//uint32_t mm_free(const uint32_t ptr);


#ifdef __cplusplus
}
#endif
#endif
