//motion encoder for mouse threadmill
//c van der Togt, 18/03/2014
//bLi modified, 12/07/2021

#define encPinA 2 
#define encPinB 3 
#define outPin 5

volatile long encPos = 0; 
volatile long SaveenPos = 0; 
unsigned long lasttime;
unsigned long lastpos = 0;
long speed = 0;
unsigned long SessionStartT = 0;

void setup() 
{ 
  pinMode(encPinA, INPUT_PULLUP); 
  pinMode(encPinB, INPUT_PULLUP); 
// encoder pin on interrupt 0 (pin 2) 
  attachInterrupt(digitalPinToInterrupt(encPinA), doEncoderA, CHANGE);
// encoder pin on interrupt 1 (pin 3) 
  attachInterrupt(digitalPinToInterrupt(encPinB), doEncoderB, CHANGE);
  Serial.begin(115200);
} 


void loop()
{
  //Do stuff here 
  if ((millis() - lasttime) > 10)
  {
   lasttime = millis(); 
   speed = (encPos-lastpos);
   lastpos = encPos;
   if( encPos != SaveenPos)
   {
    Serial.print("T");
    Serial.println(millis()-SessionStartT);
    Serial.println(encPos);
    SaveenPos = encPos;
   }
  }
  
    if (Serial.available()) {
    int m = Serial.read();
    if(m==999) {     // a code 999 is needed to initialize a session
      encPos = 0;    // zero the position
      lastpos = 0;
      SessionStartT = millis(); // set the session start time
    } 
  }
} 


void doEncoderA(){ 
  // look for a low-to-high on channel A
  if (digitalRead(encPinA) == HIGH) { 
    // check channel B to see which way encoder is turning
    if (digitalRead(encPinB) == LOW) {  
      encPos += 1;         // CW
    } 
    else {
      encPos -= 1;         // CCW
    }
  }
  else   // must be a high-to-low edge on channel A                                       
  { 
    // check channel B to see which way encoder is turning  
    if (digitalRead(encPinB) == HIGH) {   
      encPos += 1;          // CW
    } 
    else {
      encPos -= 1;          // CCW
    }
  }
  
} 


void doEncoderB(){ 
  // look for a low-to-high on channel B
  if (digitalRead(encPinB) == HIGH) {   
   // check channel A to see which way encoder is turning
    if (digitalRead(encPinA) == HIGH) {  
      encPos += 1;         // CW
    } 
    else {
      encPos -= 1;         // CCW
    }
  }
  // Look for a high-to-low on channel B
  else { 
    // check channel B to see which way encoder is turning  
    if (digitalRead(encPinA) == LOW) {   
      encPos += 1;          // CW
    } 
    else {
      encPos -= 1;          // CCW
    }
  }
} 
