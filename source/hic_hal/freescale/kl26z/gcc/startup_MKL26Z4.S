/* ------------------------------------------------------------------------- */
/*  @file:    startup_MKL26Z4.s                                              */
/*  @purpose: CMSIS Cortex-M0P Core Device Startup File                      */
/*            MKL26Z4                                                        */
/*  @version: 1.8                                                            */
/*  @date:    2015-7-29                                                      */
/*  @build:   b171205                                                        */
/* ------------------------------------------------------------------------- */
/*                                                                           */
/* Copyright 1997-2016 Freescale Semiconductor, Inc.                         */
/* Copyright 2016-2017 NXP                                                   */
/* All rights reserved.                                                      */
/*                                                                           */
/* Redistribution and use in source and binary forms, with or without        */
/* modification, are permitted (subject to the limitations in the            */
/* disclaimer below) provided that the following conditions are met:         */
/*                                                                           */
/* * Redistributions of source code must retain the above copyright          */
/*   notice, this list of conditions and the following disclaimer.           */
/*                                                                           */
/* * Redistributions in binary form must reproduce the above copyright       */
/*   notice, this list of conditions and the following disclaimer in the     */
/*   documentation and/or other materials provided with the distribution.    */
/*                                                                           */
/* * Neither the name of the copyright holder nor the names of its           */
/*   contributors may be used to endorse or promote products derived from    */
/*   this software without specific prior written permission.                */
/*                                                                           */
/* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT       */
/* HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED               */
/* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF      */
/* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE                  */
/* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE     */
/* LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR       */
/* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF      */
/* SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR           */
/* BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,     */
/* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE      */
/* OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN    */
/* IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                             */
/*****************************************************************************/
/* Version: GCC for ARM Embedded Processors                                  */
/*****************************************************************************/
    .syntax unified
    .arch armv6-m

    .section .isr_vector, "a"
    .align 2
    .globl __isr_vector
__isr_vector:
    .long   __StackTop                                      /* Top of Stack */
    .long   Reset_Handler                                   /* Reset Handler */
    .long   NMI_Handler                                     /* NMI Handler*/
    .long   HardFault_Handler                               /* Hard Fault Handler*/
    .long   0                                               /* Reserved*/
    .long   0                                               /* Reserved*/
    .long   0                                               /* Reserved*/
    .long   0                                               /* Reserved*/
    .long   DAPLINK_BUILD_KEY                               /* DAPLINK: Build type (BL/IF)*/
    .long   DAPLINK_HIC_ID                                  /* DAPLINK: Compatibility*/
    .long   DAPLINK_VERSION                                 /* DAPLINK: Version*/
    .long   SVC_Handler                                     /* SVCall Handler*/
    .long   0                                               /* Reserved*/
    .long   g_board_info                                    /* DAPLINK: Pointer to board/family/target info*/
    .long   PendSV_Handler                                  /* PendSV Handler*/
    .long   SysTick_Handler                                 /* SysTick Handler*/

                                                            /* External Interrupts*/
    .long   DMA0_IRQHandler                                 /* DMA channel 0 transfer complete and error interrupt*/
    .long   DMA1_IRQHandler                                 /* DMA channel 1 transfer complete and error interrupt*/
    .long   DMA2_IRQHandler                                 /* DMA channel 2 transfer complete and error interrupt*/
    .long   DMA3_IRQHandler                                 /* DMA channel 3 transfer complete and error interrupt*/
    .long   Reserved20_IRQHandler                           /* Reserved interrupt*/
    .long   FTFA_IRQHandler                                 /* FTFA command complete and read collision*/
    .long   LVD_LVW_IRQHandler                              /* Low-voltage detect, low-voltage warning*/
    .long   LLWU_IRQHandler                                 /* Low Leakage Wakeup*/
    .long   I2C0_IRQHandler                                 /* I2C0 interrupt*/
    .long   I2C1_IRQHandler                                 /* I2C1 interrupt*/
    .long   SPI0_IRQHandler                                 /* SPI0 single interrupt vector for all sources*/
    .long   SPI1_IRQHandler                                 /* SPI1 single interrupt vector for all sources*/
    .long   UART0_IRQHandler                                /* UART0 status and error*/
    .long   UART1_IRQHandler                                /* UART1 status and error*/
    .long   UART2_IRQHandler                                /* UART2 status and error*/
    .long   ADC0_IRQHandler                                 /* ADC0 interrupt*/
    .long   CMP0_IRQHandler                                 /* CMP0 interrupt*/
    .long   TPM0_IRQHandler                                 /* TPM0 single interrupt vector for all sources*/
    .long   TPM1_IRQHandler                                 /* TPM1 single interrupt vector for all sources*/
    .long   TPM2_IRQHandler                                 /* TPM2 single interrupt vector for all sources*/
    .long   RTC_IRQHandler                                  /* RTC alarm interrupt*/
    .long   RTC_Seconds_IRQHandler                          /* RTC seconds interrupt*/
    .long   PIT_IRQHandler                                  /* PIT single interrupt vector for all channels*/
    .long   I2S0_IRQHandler                                 /* I2S0 Single interrupt vector for all sources*/
    .long   USB0_IRQHandler                                 /* USB0 OTG*/
    .long   DAC0_IRQHandler                                 /* DAC0 interrupt*/
    .long   TSI0_IRQHandler                                 /* TSI0 interrupt*/
    .long   MCG_IRQHandler                                  /* MCG interrupt*/
    .long   LPTMR0_IRQHandler                               /* LPTMR0 interrupt*/
    .long   Reserved45_IRQHandler                           /* Reserved interrupt*/
    .long   PORTA_IRQHandler                                /* PORTA pin detect*/
    .long   PORTC_PORTD_IRQHandler                          /* Single interrupt vector for PORTC and PORTD pin detect*/

    .size    __isr_vector, . - __isr_vector

/* Flash Configuration */
    .section .FlashConfig, "a"
    .long 0xFFFFFFFF
    .long 0xFFFFFFFF
    .long 0xFFFFFFFF
    .long 0xFFFFFFFE

    .text
    .thumb

/* Reset Handler */

    .thumb_func
    .align 2
    .globl   Reset_Handler
    .weak    Reset_Handler
    .type    Reset_Handler, %function
Reset_Handler:
    cpsid   i               /* Mask interrupts */
    .equ    VTOR, 0xE000ED08
    ldr     r0, =VTOR
    ldr     r1, =__isr_vector
    str     r1, [r0]
    ldr     r2, [r1]
    msr     msp, r2
#ifndef __NO_SYSTEM_INIT
    ldr   r0,=SystemInit
    blx   r0
#endif
/*     Loop to copy data from read only memory to RAM. The ranges
 *      of copy from/to are specified by following symbols evaluated in
 *      linker script.
 *      __etext: End of code section, i.e., begin of data sections to copy from.
 *      __data_start__/__data_end__: RAM address range that data should be
 *      copied to. Both must be aligned to 4 bytes boundary.  */

    ldr    r1, =__etext
    ldr    r2, =__data_start__
    ldr    r3, =__data_end__

    subs    r3, r2
    ble     .LC0

.LC1:
    subs    r3, 4
    ldr    r0, [r1,r3]
    str    r0, [r2,r3]
    bgt    .LC1
.LC0:

#ifdef __STARTUP_CLEAR_BSS
/*     This part of work usually is done in C library startup code. Otherwise,
 *     define this macro to enable it in this startup.
 *
 *     Loop to zero out BSS section, which uses following symbols
 *     in linker script:
 *      __bss_start__: start of BSS section. Must align to 4
 *      __bss_end__: end of BSS section. Must align to 4
 */
    ldr r1, =__bss_start__
    ldr r2, =__bss_end__

    subs    r2, r1
    ble .LC3

    movs    r0, 0
.LC2:
    str r0, [r1, r2]
    subs    r2, 4
    bge .LC2
.LC3:
#endif
    cpsie   i               /* Unmask interrupts */
#ifndef __START
#define __START _start
#endif
#ifndef __ATOLLIC__
    ldr   r0,=__START
    blx   r0
#else
    ldr   r0,=__libc_init_array
    blx   r0
    ldr   r0,=main
    bx    r0
#endif
    .pool
    .size Reset_Handler, . - Reset_Handler

    .align  1
    .thumb_func
    .weak DefaultISR
    .type DefaultISR, %function
DefaultISR:
    ldr r0, =DefaultISR
    bx r0
    .size DefaultISR, . - DefaultISR

    .align 1
    .thumb_func
    .weak NMI_Handler
    .type NMI_Handler, %function
NMI_Handler:
    ldr   r0,=NMI_Handler
    bx    r0
    .size NMI_Handler, . - NMI_Handler

    .align 1
    .thumb_func
    .weak HardFault_Handler
    .type HardFault_Handler, %function
HardFault_Handler:
    ldr   r0,=HardFault_Handler
    bx    r0
    .size HardFault_Handler, . - HardFault_Handler

    .align 1
    .thumb_func
    .weak SVC_Handler
    .type SVC_Handler, %function
SVC_Handler:
    ldr   r0,=SVC_Handler
    bx    r0
    .size SVC_Handler, . - SVC_Handler

    .align 1
    .thumb_func
    .weak PendSV_Handler
    .type PendSV_Handler, %function
PendSV_Handler:
    ldr   r0,=PendSV_Handler
    bx    r0
    .size PendSV_Handler, . - PendSV_Handler

    .align 1
    .thumb_func
    .weak SysTick_Handler
    .type SysTick_Handler, %function
SysTick_Handler:
    ldr   r0,=SysTick_Handler
    bx    r0
    .size SysTick_Handler, . - SysTick_Handler

/*    Macro to define default handlers. Default handler
 *    will be weak symbol and just dead loops. They can be
 *    overwritten by other handlers */
    .macro def_irq_handler  handler_name
    .weak \handler_name
    .set  \handler_name, DefaultISR
    .endm

/* Exception Handlers */
    def_irq_handler    DMA0_IRQHandler
    def_irq_handler    DMA1_IRQHandler
    def_irq_handler    DMA2_IRQHandler
    def_irq_handler    DMA3_IRQHandler
    def_irq_handler    Reserved20_IRQHandler
    def_irq_handler    FTFA_IRQHandler
    def_irq_handler    LVD_LVW_IRQHandler
    def_irq_handler    LLWU_IRQHandler
    def_irq_handler    I2C0_IRQHandler
    def_irq_handler    I2C1_IRQHandler
    def_irq_handler    SPI0_IRQHandler
    def_irq_handler    SPI1_IRQHandler
    def_irq_handler    UART0_IRQHandler
    def_irq_handler    UART1_IRQHandler
    def_irq_handler    UART2_IRQHandler
    def_irq_handler    ADC0_IRQHandler
    def_irq_handler    CMP0_IRQHandler
    def_irq_handler    TPM0_IRQHandler
    def_irq_handler    TPM1_IRQHandler
    def_irq_handler    TPM2_IRQHandler
    def_irq_handler    RTC_IRQHandler
    def_irq_handler    RTC_Seconds_IRQHandler
    def_irq_handler    PIT_IRQHandler
    def_irq_handler    I2S0_IRQHandler
    def_irq_handler    USB0_IRQHandler
    def_irq_handler    DAC0_IRQHandler
    def_irq_handler    TSI0_IRQHandler
    def_irq_handler    MCG_IRQHandler
    def_irq_handler    LPTMR0_IRQHandler
    def_irq_handler    Reserved45_IRQHandler
    def_irq_handler    PORTA_IRQHandler
    def_irq_handler    PORTC_PORTD_IRQHandler

    .end
