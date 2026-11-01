#include <stdint.h>
#include <stm8s.h>
#include "sm.h"

void main()
{
  static enum state_t st = ST_INIT;
  st = main_sm(st);
}
