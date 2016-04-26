//Global variables
int maxDistance = 400;

//Section 1
long time1, distance1;
const int triggerPin1 = 2;
const int echoPin1 = 3;
const int ledPin1 = 4;
//Section 2
long time2, distance2;
const int triggerPin2 = 5;
const int echoPin2 = 6;
const int ledPin2 = 7;
//Section 3
long time3, distance3;
const int triggerPin3 = 8;
const int echoPin3 = 9;
const int ledPin3 = 10;
//Section 4
long time4, distance4;
const int triggerPin4 = 11;
const int echoPin4 = 12;
const int ledPin4 = 13;
//Section 5
long time5, distance5;
const int triggerPin5 = 44;
const int echoPin5 = 45;
const int ledPin5 = 46;

//Setup
void setup() {
  Serial.begin(9600);
  //Section 1
  pinMode(triggerPin1,OUTPUT);
  pinMode(echoPin1,INPUT);
  pinMode(ledPin1,OUTPUT);
  //Section 2
  pinMode(triggerPin2,OUTPUT);
  pinMode(echoPin2,INPUT);
  pinMode(ledPin2,OUTPUT);
  //Section 3
  pinMode(triggerPin3,OUTPUT);
  pinMode(echoPin3,INPUT);
  pinMode(ledPin3,OUTPUT);
  //Section 4
  pinMode(triggerPin4,OUTPUT);
  pinMode(echoPin4,INPUT);
  pinMode(ledPin4,OUTPUT);
  //Section 5
  pinMode(triggerPin5,OUTPUT);
  pinMode(echoPin5,INPUT);
  pinMode(ledPin5,OUTPUT);
}

void loop() {
  
   //Section 1 Distance Reading
   digitalWrite(triggerPin1,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin1,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin1,LOW);
   time1 = pulseIn(echoPin1,HIGH);
   distance1 = time1/58.3;
   if (distance1 <= maxDistance){
     Serial.println("Section One Distance:");
     Serial.println(distance1);
   }
   //Section 1 LED Panel Fading
   if (distance1 < 40){
      for (int fadeValue1 = 0 ; fadeValue1 <= 255; fadeValue1 += 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin1, fadeValue1);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }
      for (int fadeValue1 = 255 ; fadeValue1 >= 0; fadeValue1 -= 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin1, fadeValue1);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }  }  
   if (distance1 > 40){
     digitalWrite(ledPin1,LOW);
   }     
   
   //Section 2 Distance Reading
   digitalWrite(triggerPin2,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin2,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin2,LOW);
   time2 = pulseIn(echoPin2,HIGH);
   distance2 = time2/58.3;
   if (distance2 <= maxDistance){
     Serial.println("Section Two Distance:");
     Serial.println(distance2);
   }
   //Section 2 LED Panel Fading
   if (distance2 < 40){
      for (int fadeValue2 = 0 ; fadeValue2 <= 255; fadeValue2 += 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin2, fadeValue2);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }
      for (int fadeValue2 = 255 ; fadeValue2 >= 0; fadeValue2 -= 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin2, fadeValue2);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }  }  
   if (distance2 > 40){
     digitalWrite(ledPin2,LOW);
   }   
   
   //Section 3 Distance Reading
   digitalWrite(triggerPin3,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin3,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin3,LOW);
   time3 = pulseIn(echoPin3,HIGH);
   distance3 = time3/58.3;
   if (distance3 <= maxDistance){
     Serial.println("Section Three Distance:");
     Serial.println(distance3);
   }
   //Section 3 LED Panel Fading
   if (distance3 < 40){
      for (int fadeValue3 = 0 ; fadeValue3 <= 255; fadeValue3 += 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin3, fadeValue3);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }
      for (int fadeValue3 = 255 ; fadeValue3 >= 0; fadeValue3 -= 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin3, fadeValue3);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }  }  
   if (distance3 > 40){
     digitalWrite(ledPin3,LOW);
   }   
   
   //Section 4 Distance Reading
   digitalWrite(triggerPin4,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin4,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin4,LOW);
   time4 = pulseIn(echoPin4,HIGH);
   distance4 = time4/58.3;
   if (distance4 <= maxDistance){
     Serial.println("Section Four Distance:");
     Serial.println(distance4);
   }
   //Section 4 LED Panel Fading
   if (distance4 < 40){
      for (int fadeValue4 = 0 ; fadeValue4 <= 255; fadeValue4 += 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin4, fadeValue4);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }
      for (int fadeValue4 = 255 ; fadeValue4 >= 0; fadeValue4 -= 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin4, fadeValue4);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }  }  
   if (distance4 > 40){
     digitalWrite(ledPin4,LOW);
   }   
   
   //Section 5 Distance Reading
   digitalWrite(triggerPin5,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin5,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin5,LOW);
   time5 = pulseIn(echoPin5,HIGH);
   distance5 = time5/58.3;
   if (distance5 <= maxDistance){
     Serial.println("Section Five Distance:");
     Serial.println(distance5);
   }
   //Section 5 LED Panel Fading
   if (distance5 < 40){
      for (int fadeValue5 = 0 ; fadeValue5 <= 255; fadeValue5 += 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin5, fadeValue5);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }
      for (int fadeValue5 = 255 ; fadeValue5 >= 0; fadeValue5 -= 5) {
      // sets the value (range from 0 to 255):
      analogWrite(ledPin5, fadeValue5);
      // wait for 30 milliseconds to see the dimming effect
      delay(30); }  }  
   if (distance5 > 40){
     digitalWrite(ledPin5,LOW);
   }    
}
