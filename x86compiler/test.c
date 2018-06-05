#include <qtum.h>
#include <stdlib.h>
#include <string.h>

//__qtum_syscall(0x40, INTERNAL_PRINT, stringlen, stringptr, ... );
#define INTERNAL_PRINT 0xFFFF0001

char* data="\n\n\n \
            ***********\n \
            Hello Seoul, May 23rd, 2018. \n \
            First Lucky Number is : 246 \n \
            ***********\n \
            \n\n\n";

void onCreate() {
    //for test only
}

int main(){
    __qtum_syscall(INTERNAL_PRINT, (long) data, 200, 0, 0, 0, 0);
    return 1;
}
