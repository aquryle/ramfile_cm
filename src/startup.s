    .syntax unified
    .cpu cortex-m33
    .thumb

    .section .isr_vector, "a", %progbits
    .type g_pfnVectors, %object
    .size g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
    .word _estack             /* 初期スタックポインタ */
    .word Reset_Handler       /* リセットハンドラ */
    .word NMI_Handler
    .word HardFault_Handler
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word DebugMon_Handler
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler

    .section .text.Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function



Reset_Handler:
    /* データセクションのクリア */
    LDR   R0, =_sdata
    LDR   R1, =_edata
clear_data_loop:
    CMP   R0, R1
    BGE   clear_bss
    MOVS  R2, #0
    STR   R2, [R0], #4
    B     clear_data_loop

clear_bss:
    LDR   R0, =_sbss
    LDR   R1, =_ebss
clear_bss_loop:
    CMP   R0, R1
    BGE   start_main
    MOVS  R2, #0
    STR   R2, [R0], #4
    B     clear_bss_loop

start_main:
    BL    main   /* main() 呼び出し */

hang:
    B hang

/* デフォルトハンドラ */
    .weak NMI_Handler
    .type NMI_Handler, %function
NMI_Handler: B hang

    .weak HardFault_Handler
    .type HardFault_Handler, %function
HardFault_Handler: B hang

    .weak MemManage_Handler
    .type MemManage_Handler, %function
MemManage_Handler: B hang

    .weak BusFault_Handler
    .type BusFault_Handler, %function
BusFault_Handler: B hang

    .weak UsageFault_Handler
    .type UsageFault_Handler, %function
UsageFault_Handler: B hang

    .weak SVC_Handler
    .type SVC_Handler, %function
SVC_Handler: B hang

    .weak DebugMon_Handler
    .type DebugMon_Handler, %function
DebugMon_Handler: B hang

    .weak PendSV_Handler
    .type PendSV_Handler, %function
PendSV_Handler: B hang

    .weak SysTick_Handler
    .type SysTick_Handler, %function
SysTick_Handler: B hang
