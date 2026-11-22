#include <stdint.h>
#include <stm8s.h>
#include "sm.h"

void main()
{
  	enum state_t st = ST_INIT;
	CLK->CKDIVR = 0x00;
	while(1){
		st = main_sm(st);
	}
}
