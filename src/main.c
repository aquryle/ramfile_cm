#include "stdint.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"


#define REGISTER_BASE   (0x00001000)
#define REGISTER0       (*(volatile uint32_t*)(REGISTER_BASE + 0x00))
#define REGISTER1       (*(volatile uint32_t*)(REGISTER_BASE + 0x04))
#define REGISTER2       (*(volatile uint32_t*)(REGISTER_BASE + 0x08))
#define REGISTER3       (*(volatile uint32_t*)(REGISTER_BASE + 0x0C))


uint32_t func_add(uint32_t a, uint32_t b)
{
    return (a + b);
}

int main(void)
{

    while (1) {
        REGISTER0 = 1;
        REGISTER1 = func_add(REGISTER2, REGISTER3);
        REGISTER0 = 0;
    }
    return 0;
}





