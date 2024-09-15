#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

#include "memory_manage.h"

#include "xprintf.h"

#define MAX_MEM_ALLOC 64U

//static uint32_t g_addr=0, end_addr=0;
//static uint32_t start_addr=0, end_addr=0;

static m_region_t *m_region_table;
static uint32_t m_region_table_len;
static uint32_t m_region_table_max_len;
static m_region_t region_with_region_table;

// int mm_set_initial(uint32_t start_addr, uint32_t mm_sz)
// {
// 	g_addr = start_addr;
// 	end_addr = g_addr + mm_sz;

// 	return 0;
// }

uint32_t get_aligned_ptr(uint32_t ptr, uint32_t alignment)
{
	uint32_t aligned_ptr = ptr &~ (alignment - 1U);
	if(aligned_ptr!=ptr)
		aligned_ptr+=alignment;
	return aligned_ptr;
}

uint32_t mm_reserve(uint32_t sz)
{
	return mm_malloc(sz, 0U);
	// void * res = g_addr;
	// if((g_addr+sz)>end_addr)
	// 	return 0;
	// else {
	// 	g_addr += sz;
	// 	return res;
	// }
}

uint32_t mm_reserve_align(uint32_t sz, uint32_t alignment_size)
{
	return mm_malloc(sz, alignment_size);
	// uint32_t res = g_addr&~(alignment_size - 1U);
	// if(res!=g_addr)
	// 	res+=alignment_size;
	
	// if((res+sz)>end_addr)
	// 	return 0;
	// else {
	// 	g_addr = res+sz;
	// 	return res;
	// }

}

void mm_init(const uint8_t total_regions, const m_region_t * regions)
{
	uint32_t m_region_table_size = (uint32_t)sizeof(m_region_t) * total_regions;
	uint32_t m_alloc_table_size = (uint32_t)sizeof(m_alloc_t) * MAX_MEM_ALLOC;\
	m_region_t current_region = regions[0];
	uint8_t i = 1;
	while (current_region.end_addr - current_region.start_addr < m_region_table_size + m_alloc_table_size + 4U) {
		if (total_regions == i) {
			return;
		}
		current_region = regions[i++];
	}
	m_region_table = memcpy(current_region.start_addr, regions, m_region_table_size);
	m_alloc_t * m_alloc_table = (current_region.start_addr + m_region_table_size + 4U) &~ 3U;
	m_region_table[--i].m_alloc_table = m_alloc_table;
	m_region_table[i].m_alloc_table[0] = (m_alloc_t){ .ptr = m_region_table, .size = m_region_table_size };
	m_region_table[i].m_alloc_table[1] = (m_alloc_t){ .ptr = m_alloc_table, .size = m_alloc_table_size };
	m_region_table[i].m_alloc_table_len = 2;
	m_region_table_len = total_regions;
	region_with_region_table = m_region_table[i];
	return;
}

void * mm_malloc(const uint32_t sz, const uint32_t alignment)
{
	xprintf("mm_malloc\n");
	uint32_t new_alloc_ptr = NULL;

	/* Iterate through all memory regions */
	for (uint32_t z = 0; z < m_region_table_len; z++) {

		/* Case 1: The allocation table is full, continue to next memory region */
		if (MAX_MEM_ALLOC == m_region_table[z].m_alloc_table_len) {
			continue;
		}

		/* Case 2: No memory or no allocation table has been created, allocate memory and allocation table if needed */
		/*
		if (region_with_region_table.start_addr == m_region_table[z].start_addr) {
			if (3 > m_region_table[z].m_alloc_table_len) {
				
				if (m_region_table[z].end_addr - ((uint32_t)m_region_table[z].m_alloc_table[1].ptr + m_region_table[z].m_alloc_table[1].size) < sz + alignment) {
					continue;
				}
				if (alignment == 0U) {
					new_alloc_ptr = (uint32_t)m_region_table[z].m_alloc_table[1].ptr + m_region_table[z].m_alloc_table[1].size;
				} else {
					new_alloc_ptr = get_aligned_ptr((uint32_t)m_region_table[z].m_alloc_table[1].ptr + m_region_table[z].m_alloc_table[1].size, alignment);
				}
				//((uint32_t)current_region.m_alloc_table[1].ptr + current_region.m_alloc_table[1].size + alignment) &~ (alignment - 1U);
				m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len++] = (m_alloc_t){ .ptr = new_alloc_ptr, .size = sz };
				//current_region.m_alloc_table_len = 5U;
				xprintf("Case 2a\n");
				xprintf("Allocated %d bytes at %d\n", sz, new_alloc_ptr);
				return (void *)new_alloc_ptr;
			}
		}
		else {
			if (2 > m_region_table[z].m_alloc_table_len) {
				if (NULL == m_region_table[z].m_alloc_table) {
					xprintf("Creating Alloc Table\n");
					m_region_table[z].m_alloc_table = (m_alloc_t *)(m_region_table[z].start_addr);
					m_region_table[z].m_alloc_table[0] = (m_alloc_t){ .ptr = m_region_table[z].m_alloc_table, .size = (uint32_t)sizeof(m_alloc_t) * MAX_MEM_ALLOC };
					m_region_table[z].m_alloc_table_len = 1;
				}
				if (m_region_table[z].end_addr - ((uint32_t)m_region_table[z].m_alloc_table[0].ptr + m_region_table[z].m_alloc_table[0].size) < sz + alignment) {
					continue;
				}
				if (alignment == 0U) {
					new_alloc_ptr = (uint32_t)m_region_table[z].m_alloc_table[0].ptr + m_region_table[z].m_alloc_table[0].size;
				} else {
					new_alloc_ptr = get_aligned_ptr((uint32_t)m_region_table[z].m_alloc_table[0].ptr + m_region_table[z].m_alloc_table[0].size, alignment);
				}
				//((uint32_t)current_region.m_alloc_table[0].ptr + current_region.m_alloc_table[0].size + alignment) &~ (alignment - 1U);
				m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len++] = (m_alloc_t){ .ptr = new_alloc_ptr, .size = sz };
				xprintf("Case 2b\n");
				xprintf("Allocated %d bytes at %d\n", sz, new_alloc_ptr);
				return (void *)new_alloc_ptr;
			}
		}*/
		if (NULL == m_region_table[z].m_alloc_table) {
			xprintf("Creating Alloc Table\n");
			m_region_table[z].m_alloc_table = (m_alloc_t *)(m_region_table[z].start_addr);
			m_region_table[z].m_alloc_table[0] = (m_alloc_t){ .ptr = m_region_table[z].m_alloc_table, .size = (uint32_t)sizeof(m_alloc_t) * MAX_MEM_ALLOC };
			m_region_table[z].m_alloc_table_len=1;
		}
		
		/* Case 3: Memory between exisiting memory allocation is enough, allocate memory there and insert allocation log in between already existing logs*/
		for (uint32_t i = 1; i < m_region_table[z].m_alloc_table_len; i++) {
			if ((uint32_t)m_region_table[z].m_alloc_table[i].ptr - ((uint32_t)m_region_table[z].m_alloc_table[i - 1].ptr + m_region_table[z].m_alloc_table[i - 1].size) < sz + alignment) {
				continue;
			}
			if (alignment == 0U) {
				new_alloc_ptr = (uint32_t)m_region_table[z].m_alloc_table[i - 1].ptr + m_region_table[z].m_alloc_table[i - 1].size;
			} else {
				new_alloc_ptr = get_aligned_ptr((uint32_t)m_region_table[z].m_alloc_table[i - 1].ptr + m_region_table[z].m_alloc_table[i - 1].size, alignment);
			}
			for (uint32_t j = i; j < m_region_table[z].m_alloc_table_len; j++) {
				m_region_table[z].m_alloc_table[j + 1] = m_region_table[z].m_alloc_table[j];
			}
			m_region_table[z].m_alloc_table[i] = (m_alloc_t){ .ptr = new_alloc_ptr, .size = sz };
			xprintf("Case 3\n");
			xprintf("Allocated %d bytes at %d\n", sz, new_alloc_ptr);
			return (void *)new_alloc_ptr;
		}

		/* Case 4: Remaining memory is not enough, continue to next memory region */
		if (m_region_table[z].end_addr - ((uint32_t)m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].ptr + m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].size) < sz + alignment) {
			xprintf("Case 4\n");
			continue;
		}

		/* Case 5: Remaining memory is enough, allocate memory */
		if (alignment == 0U) {
			new_alloc_ptr = (uint32_t)m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].ptr + m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].size;
		} else {
			new_alloc_ptr = get_aligned_ptr((uint32_t)m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].ptr + m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len - 1].size, alignment);
		}
		m_region_table[z].m_alloc_table[m_region_table[z].m_alloc_table_len++] = (m_alloc_t){ .ptr = new_alloc_ptr, .size = sz };
		xprintf("Allocated %d bytes at %d\n", sz, new_alloc_ptr);
		return (void *)new_alloc_ptr;
	}
	return new_alloc_ptr;	// Failed to allocate memory
}

uint32_t mm_realloc(const uint32_t ptr, const uint32_t sz)
{
}

uint32_t mm_free(const uint32_t ptr)
{
}