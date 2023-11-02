
#include <OneWire.h>
#include <DallasTemperature.h>
#include <LiquidCrystal.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <UniversalTelegramBot.h>

// Telegram BOT Token (Get from Botfather)
#define BOT_TOKEN "6350342467:AAHvajFe7Kb4tdaFS3RO7ULHnJcwneXNqvM"
WiFiClientSecure secured_client;
UniversalTelegramBot bot(BOT_TOKEN, secured_client);

//#define DEBUG (1)
#define ESP8266
#define USEWIFI
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


#ifndef USEWIFI
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
#else
int port = 8888;
WiFiUDP udp;
char incomingPacket[256];
const char *ssid = "DongXia_AP";
const char *password = "mywififoralexa";
const char *ipaddr = "192.168.4.2";
char tempHead[] = "temp:";
char rlyHead[] = "rly:";
char maxMinHead[] = "maxmin:";
char rlyCntHead[] = "rcnt:";
bool relayState;
#endif

OneWire onewire(ONE_WIRE_BUS);
DallasTemperature tempSensor(&onewire);

//filter buffer
static float buffer[FILTER_SZ];


void setup() {

  #ifdef DEBUG
    Serial.begin(9600);
  #endif

  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(RELAY_PIN, OUTPUT);
  relayState = false;
  tempSensor.begin();
  
  #ifdef USEWIFI
  WiFi.softAP(ssid, password);
  udp.begin(port);
  sndUdpPacket(rlyHead, 0);
  #else
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  lcd.setCursor(0,0);
  lcd.print("T:         N:");
  lcd.setCursor(0,1);
  lcd.print("RLY:OFF[  -  ]*C"); 
  #endif
  
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
  #ifndef USEWIFI
    DisplayTemp(temp);
  #else
    //send the temperature via udp
    sndUdpPacket(tempHead, (int) temp);
  #endif
  maxTemp = (maxTemp<temp)?temp:maxTemp;
  minTemp = (minTemp>temp)?temp:minTemp;
  #ifndef USEWIFI
  DisplayMaxMinTemp(maxTemp,minTemp);
  #else
  int maxmin = (int(maxTemp+0.5) << 8) + (int(minTemp+0.5));
  sndUdpPacket(maxMinHead, maxmin);
  #endif
  ReactWithTemp(temp, &rlyCnter);
  #ifndef USEWIFI
  DisplayRelayCounter(rlyCnter);
  #else
  sndUdpPacket(rlyCntHead, rlyCnter);
  sndUdpPacket(rlyHead, relayState?1:0);
  #endif
}

#ifndef USEWIFI
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
#endif

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

#ifndef USEWIFI
  lcd.setCursor(4,1);
  lcd.print("ON ");
#else
  //sndUdpPacket(rlyHead, 1);
  relayState = true;
#endif
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

#ifndef USEWIFI
  lcd.setCursor(4,1);
  lcd.print("OFF");
#else
  //sndUdpPacket(rlyHead, 0);
  relayState = false;
#endif
}

#ifdef USEWIFI
void sndUdpPacket(char * preStr, int val)
{ 
    String str = String(val);
    udp.beginPacket(ipaddr, port);
    udp.write(preStr);
    udp.write(str.c_str());
    udp.write(";");
    udp.endPacket();
}
#endif
