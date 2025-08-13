#include "stdint.h"
#include "stdbool.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"

#include "reg.h"
#include "add.h"


int main(void)
{

    while (1) {
        REGISTER0 = 1;
        REGISTER1 = func_add(REGISTER2, REGISTER3);
        REGISTER0 = 0;
    }
    return 0;
}





