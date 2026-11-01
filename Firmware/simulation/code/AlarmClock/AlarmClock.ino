#include <Arduino.h>
#include "sm.h"
void setup()
{  
}

void loop()
{
  static enum state_t st = ST_INIT;
  st = main_sm(st);
}
