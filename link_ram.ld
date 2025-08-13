/* link_ram.ld - RAM上で動作するCortex-M33用リンカスクリプト */

ENTRY(Reset_Handler)

/* RAM領域定義 */
MEMORY
{
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 32K
}

/* スタックとヒープサイズ */
STACK_SIZE = 2K;
HEAP_SIZE  = 1K;
_estack = ORIGIN(RAM) + LENGTH(RAM);

/* セクション割り当て */
SECTIONS
{
    /* 実行コード */
    .text :
    {
        KEEP(*(.isr_vector))   /* ベクターテーブル */
        *(.text*)              /* コード */
        *(.rodata*)            /* 読み取り専用データ */
        _etext = .;            /* .textの終了アドレス */
    } > RAM

    /* 初期化済みデータ */
    .data :
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM AT> RAM

    /* 未初期化データ */
    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM

    /* スタック領域 */
    .stack (NOLOAD):
    {
        . = . + STACK_SIZE;
    } > RAM

    /* ヒープ領域 */
    .heap (NOLOAD):
    {
        . = . + HEAP_SIZE;
    } > RAM
}
