//motion encoder for mouse threadmill
//c van der Togt, 18/03/2014

#define encPinA 2 
#define encPinB 3 

long encPos = 0; 
long Speed = 0;
long Time = 0;
long prevCnt = 0;
long prevTime = 0;
//boolean update = false;

void setup() 
{ 
  pinMode(encPinA, INPUT_PULLUP); 
  pinMode(encPinB, INPUT_PULLUP); 
// encoder pin on interrupt 0 (pin 2) 
  attachInterrupt(digitalPinToInterrupt(encPinA), doEncoderA, CHANGE);
// encoder pin on interrupt 1 (pin 3) 
  attachInterrupt(digitalPinToInterrupt(encPinB), doEncoderB, CHANGE);  
  Serial.begin (115200);
} 


void loop()
{
  byte m;
  if (Serial.available()) {
    m = Serial.read();
    if(m==0) {
          Time = millis();             
          Speed = (Speed + (encPos - prevCnt)*1000/(Time - prevTime))/2;
          Serial.write((byte *) &Speed, 4);      
          prevCnt = encPos;
          prevTime = Time;
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
//    update=true;
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
//  update=true;  
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
//  update=true;
} 
