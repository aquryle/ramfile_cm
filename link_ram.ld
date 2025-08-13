

ENTRY(Reset_Handler)

/* RAM領域定義 */
MEMORY
{
    RAM0 (rwx) : ORIGIN = 0x04000000, LENGTH = 16K
    RAM1 (rwx) : ORIGIN = 0x20000000, LENGTH = 112K
}

/* スタック・ヒープはRAM1の末尾に配置 */
STACK_SIZE = 2K;
HEAP_SIZE  = 1K;
_estack = ORIGIN(RAM1) + LENGTH(RAM1);


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
    } > RAM0

    /* 初期化済みデータ */
    .data :
    {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM0


    /* 未初期化データ */
    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM0


    /* スタック領域 */
    .stack (NOLOAD):
    {
        . = . + STACK_SIZE;
    } > RAM1

    /* ヒープ領域 */
    .heap (NOLOAD):
    {
        . = . + HEAP_SIZE;
    } > RAM1

}
