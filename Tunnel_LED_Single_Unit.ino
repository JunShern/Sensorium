const int triggerPin = 8;
const int echoPin = 9;
long time, distance;
int maxDistance = 400;
const int ledPin = 11;

void setup() {
  Serial.begin(9600);
  pinMode(triggerPin,OUTPUT);
  pinMode(echoPin,INPUT);
  pinMode(ledPin,OUTPUT);
}

void loop() {
   digitalWrite(triggerPin,LOW);
   delayMicroseconds(2);
   digitalWrite(triggerPin,HIGH);
   delayMicroseconds(10);
   digitalWrite(triggerPin,LOW);
   time = pulseIn(echoPin,HIGH);
   distance = time/58.3;
   if (distance <= maxDistance){
     Serial.println(distance);
   }
   
   if (distance < 40){
     
    for (int fadeValue = 0 ; fadeValue <= 255; fadeValue += 5) {
    // sets the value (range from 0 to 255):
    analogWrite(ledPin, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
    }
     for (int fadeValue = 255 ; fadeValue >= 0; fadeValue -= 5) {
    // sets the value (range from 0 to 255):
    analogWrite(ledPin, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
     }  
  }  
   if (distance > 40){
     digitalWrite(ledPin,LOW);
   }     
}
