
#include <OneWire.h>
#include <DallasTemperature.h>
#include <LiquidCrystal.h>

//#define DEBUG (1)

#define ESP8266
#define TEMP_HIGH_LIM 40.0f
#define TEMP_LOW_LIM 38.0f
#define FILTER_SZ 50

// initialize the library by associating any needed LCD interface pin
// with the arduino pin number it is connected to
#ifndef ESP8266
#define ONE_WIRE_BUS 3
#define RELAY_PIN 4
const int rs = 10, en = 9, d4 = 8, d5 = 7, d6 = 6, d7 = 5;
#else 
#define ONE_WIRE_BUS 4
#define RELAY_PIN 5
//const int rs = D3, en = D4, d4 = D6, d5 = D5, d6 = D8, d7 = D7;
const int rs = 0, en = 2, d4 = 12, d5 = 14, d6 = 15, d7 = 13;
#endif

LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

OneWire onewire(ONE_WIRE_BUS);
DallasTemperature tempSensor(&onewire);

static float buffer[FILTER_SZ];


void setup() {

  #ifdef DEBUG
    Serial.begin(9600);
  #endif
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(RELAY_PIN, OUTPUT);
  
  tempSensor.begin();
  
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  lcd.setCursor(0,0);
  lcd.print("T:         N:");
  lcd.setCursor(0,1);
  lcd.print("RLY:OFF[  -  ]*C"); 
  
  for(int i = 0; i < FILTER_SZ; i++) buffer[i] = 0.0f;  
}

void loop() {
  static float sum = 0.0f;
  static int idx = 0;
  static float maxTemp = 0, minTemp = 999.0;
  static bool isNotReady = 1;
  static int rlyCnter = 0;
  
  tempSensor.requestTemperatures(); // Send the command to get temperatures
  float temp = tempSensor.getTempCByIndex(0);
  #ifdef DEBUG
    Serial.println(temp);
  #endif
  //Moving average the temperature
  sum += temp;
  sum -= buffer[idx];
  buffer[idx] = temp;
  idx =  (idx < FILTER_SZ - 1)?(idx+1):0;

  temp = sum/FILTER_SZ;
  #ifdef DEBUG
    Serial.print("averaged:");
    Serial.println(temp);
  #endif
  if(isNotReady && (idx == FILTER_SZ -1)) isNotReady = 0;
  // Print a message to the LCD.
  if(isNotReady) return;
  DisplayTemp(temp);
  maxTemp = (maxTemp<temp)?temp:maxTemp;
  minTemp = (minTemp>temp)?temp:minTemp;
  DisplayMaxMinTemp(maxTemp,minTemp);
  ReactWithTemp(temp, &rlyCnter);
  DisplayRelayCounter(rlyCnter);  
}


void DisplayTemp(float temp)
{
  lcd.setCursor(2,0);
  if(temp > 99.9f) lcd.print("N/A");
  else if(temp < 0.0f) lcd.print("ERR!");
  else {
    int inttemp = temp * 1000 + 5;  
    lcd.print((float)inttemp/1000.0f);
    lcd.print("*C");
  }
}

void DisplayMaxMinTemp(float maxtemp, float mintemp)
{
  lcd.setCursor(8,1);
  lcd.print(int(mintemp+0.5));
  lcd.print("-");
  lcd.print(int(maxtemp+0.5));
}

void DisplayRelayCounter(int no)
{
  lcd.setCursor(13,0);
  lcd.print(no);
}

uint8_t ReactWithTemp(float temp, int * pcnter)
{
  static uint8_t statusRelay = 0;
  if((temp <= TEMP_LOW_LIM) && (statusRelay == 0))
  {
    statusRelay = 1;
    RelayOn();
    (*pcnter)++;    
  }
  if((temp >= TEMP_HIGH_LIM) && (statusRelay == 1))
  {
    statusRelay = 0;
    RelayOff();
    (*pcnter)++;
  }
  return statusRelay;
}

void RelayOn()
{
#ifndef ESP8266
  digitalWrite(LED_BUILTIN, HIGH);
#endif
  digitalWrite(RELAY_PIN, HIGH);
#ifdef DEBUG
  Serial.println("RELAY ON");
#endif
  lcd.setCursor(4,1);
  lcd.print("ON ");
}

void RelayOff()
{
#ifndef ESP8266
  digitalWrite(LED_BUILTIN, LOW);
#endif
  digitalWrite(RELAY_PIN, LOW);
#ifdef DEBUG
  Serial.println("RELAY OFF");
#endif  
  lcd.setCursor(4,1);
  lcd.print("OFF");
}
