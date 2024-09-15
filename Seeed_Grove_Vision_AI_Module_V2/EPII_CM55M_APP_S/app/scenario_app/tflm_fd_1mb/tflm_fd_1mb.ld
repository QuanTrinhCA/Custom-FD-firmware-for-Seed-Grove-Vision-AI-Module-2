#include "WE2_device_addr.h"

#define SRAMA_START     BASE_ADDR_SRAM0_ALIAS
#define SRAMA_BASE      (BOOT2NDLOADER_BASE + BOOT2NDLOADER_SIZE)
#define SRAMA_SIZE      (SRAM0_SIZE + SRAM1_SIZE) - (SRAMA_BASE - SRAMA_START)

#define SRAMB_BASE      BASE_ADDR_SRAM2_ALIAS
#define SRAMB_SIZE      SRAM2_SIZE

/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions FLASH and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 *
 * It defines following symbols, which code can use without definition:
 *   __exidx_start
 *   __exidx_end
 *   __copy_table_start__
 *   __copy_table_end__
 *   __zero_table_start__
 *   __zero_table_end__
 *   __etext
 *   __data_start__
 *   __preinit_array_start
 *   __preinit_array_end
 *   __init_array_start
 *   __init_array_end
 *   __fini_array_start
 *   __fini_array_end
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 *   __StackSeal      (only if ARMv8-M stack sealing is used)
 */

MEMORY
{
  ICTM (rx) : ORIGIN = BASE_ADDR_ITCM_ALIAS, LENGTH = ITCM_SIZE
  DCTM (rwx) : ORIGIN = BASE_ADDR_DTCM_ALIAS, LENGTH = DTCM_SIZE
  SRAMA (rwx) : ORIGIN = SRAMA_BASE, LENGTH = SRAMA_SIZE
  SRAMB (rwx) : ORIGIN = SRAMB_BASE, LENGTH = SRAMB_SIZE
}

__STACK_SIZE = 0x0004000;
__HEAP_SIZE = 0x0004000;
//__HEAP_SIZE = 0x26000;
//__STACK_SIZE = 0xA000;

ENTRY(Reset_Handler)

SECTIONS
{
  .text :
  {
    FILL(0xff)
    . = ALIGN(4);
    KEEP(*(.vectors))

    . = ALIGN(4);
    *(.text*)
    __etext = .;

    . = ALIGN(4);
    KEEP(*(.init))
    KEEP(*(.fini))
    

    . = ALIGN(4);
    KEEP(*(.eh_frame*))
  } > ICTM

  .ARM.extab : ALIGN(4)
  {
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > ICTM

  .ARM.exidx : ALIGN(4)
  { 
    __exidx_start = .;
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    __exidx_end = .;
  } > ICTM

  .copy.table :
  {
    . = ALIGN(4);
    __copy_table_start__ = .;
      LONG(LOADADDR(.data));
      LONG(    ADDR(.data));
      LONG(  SIZEOF(.data)/4);
    __copy_table_end__ = .;
  } > ICTM

  .zero.table :
  {
    . = ALIGN(4);
    __zero_table_start__ = .;
    /*
      LONG(    ADDR(.bss));
      LONG(  SIZEOF(.bss)/4);
    */
    __zero_table_end__ = .;
  } > ICTM

  .data :
  {
    FILL(0xff)
    . = ALIGN(4);
    __data_start__ = .;
    
    PROVIDE_HIDDEN(__preinit_array_start = .);
    KEEP(*(.preinit_array))
    PROVIDE_HIDDEN(__preinit_array_end = .);

    . = ALIGN(4);
    PROVIDE_HIDDEN(__init_array_start = .);
    KEEP(*(SORT_BY_INIT_PRIORITY(.init_array.*)))
    KEEP(*(.init_array))
    PROVIDE_HIDDEN(__init_array_end = .);

    . = ALIGN(4);
    PROVIDE_HIDDEN(__fini_array_start = .);
    KEEP(*(SORT_BY_INIT_PRIORITY(.fini_array.*)))
    KEEP(*(.fini_array))
    PROVIDE_HIDDEN(__fini_array_end = .);

    KEEP(*(.jcr*))

    //. = ALIGN(4);
    //*(vtable)

    . = ALIGN(4);
    *(.data.*)
    *(.data)
    
    . = ALIGN(4);
    __data_end__ = .;
  } > DCTM

  .rodata :
  {
    . = ALIGN(4);
    __rodata_start = .;
    *(.rodata.*)
    *(.rodata)
    . = ALIGN(4);
    __rodata_end = .;
  } > DCTM

  .bss :
  {
    . = ALIGN(4);
    __bss_start__ = .;
    *(.bss.*)
    *(.bss)
    *(COMMON)
    . = ALIGN(4);
    __bss_end__ = .;
  } > DCTM
  
  .heap (COPY) :
  {
    . = ALIGN(8);
    __end__ = .;
    PROVIDE(end = .);
    __HeapBase = end;
    . = . + __HEAP_SIZE;
    . = ALIGN(8);
    __HeapLimit = .;
  } > DCTM

  .stack (ORIGIN(DCTM) + LENGTH(DCTM) - __STACK_SIZE) (COPY) :
  {
    . = ALIGN(8);
    __StackLimit = .;
    PROVIDE(__StackLimit = .);
    . = . + __STACK_SIZE;
    . = ALIGN(8);
    __StackTop = .;
    PROVIDE(__StackTop = .);   
  } > DCTM
  PROVIDE(__stack = __StackTop);

  /* Check if data + heap + stack exceeds RAM limit */
  ASSERT(__StackLimit >= __HeapLimit, "region RAM overflowed with stack")
  
  /* Provide basic symbols giving location and size of main text
   * block, including initial values of RW data sections. Note that
   * these will need extending to give a complete picture with
   * complex images (e.g multiple Flash banks).
   */
  _image_start = LOADADDR(.text);
  _image_end = LOADADDR(.data) + SIZEOF(.data);
  _image_size = _image_end - _image_start;
}