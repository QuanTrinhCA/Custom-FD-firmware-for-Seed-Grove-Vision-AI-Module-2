/*
 * pdm_record.h
 *
 *  Created on: Aug 15, 2023
 *      Author: 902449
 */

#ifndef APP_SCENARIO_PDM_RECORD_
#define APP_SCENARIO_PDM_RECORD_

#define APP_BLOCK_FUNC() do{ \
	__asm volatile("b    .");\
	}while(0)

int app_main(void);

#endif /* APP_SCENARIO_PDM_SINGLE_ */
