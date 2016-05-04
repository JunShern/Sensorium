OPC opc;
PImage dot;
int backgroundThreshold = 3000;  
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;
IntList xArray;
IntList yArray;
int maxArrayLength = 15;

void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  initLED();
}

void draw()
{
  //background(0);
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  PImage depthImage = kinect.depthImage();
  int[] depthValues = kinect.depthMap();
  depthImage.loadPixels();
  for (int i = 0; i < width * height; i++) {
    if (depthValues[i] > backgroundThreshold) { 
      depthImage.pixels[i] = color(0);
    } 
  }
  // Draw image
  //tint(255, 128);
  image(depthImage, 0, 0);
  scale(-1,1);//flip on X axis
}

void mousePressed() {
  int[] depthValues = kinect.depthMap();
  int clickIndex = mouseX + (mouseY * 640);
  
  int millimeters = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  float inches = millimeters / 25.4;
  backgroundThreshold = millimeters;
  println("mm: ", millimeters, "  Inches: " + inches);
  println("");
}

void initLED() {
  opc.ledStrip((0+0)*64 + 0, 18, width/2, height*1/48, width/18.0, 0, false);
  opc.ledStrip((0+0)*64 + 19, 18, width/2, height*3/48, width/18.0, 0, true);
  opc.ledStrip((0+0)*64 + 38, 18, width/2, height*5/48, width/18.0, 0, false);
  opc.ledStrip((0+1)*64 + 0, 18, width/2, height*7/48, width/18.0, 0, true);
  opc.ledStrip((0+1)*64 + 19, 18, width/2, height*9/48, width/18.0, 0, false);
  opc.ledStrip((0+1)*64 + 38, 18, width/2, height*11/48, width/18.0, 0, true);
  opc.ledStrip((0+2)*64 + 0, 18, width/2, height*13/48, width/18.0, 0, false);
  opc.ledStrip((0+2)*64 + 19, 18, width/2, height*15/48, width/18.0, 0, true);
  opc.ledStrip((0+2)*64 + 38-2, 18, width/2, height*17/48, width/18.0, 0, false);
  
  opc.ledStrip((3+0)*64 + 0, 18, width/2, height*19/48, width/18.0, 0, true);
  opc.ledStrip((3+0)*64 + 19, 18, width/2, height*21/48, width/18.0, 0, false);
  opc.ledStrip((3+0)*64 + 38, 18, width/2, height*23/48, width/18.0, 0, true);
  opc.ledStrip((3+1)*64 + 0, 18, width/2, height*25/48, width/18.0, 0, false);
  opc.ledStrip((3+1)*64 + 19, 18, width/2, height*27/48, width/18.0, 0, true);
  opc.ledStrip((3+1)*64 + 38, 18, width/2, height*29/48, width/18.0, 0, false);
  opc.ledStrip((3+2)*64 + 0, 18, width/2, height*31/48, width/18.0, 0, true);
  opc.ledStrip((3+2)*64 + 19-2, 18, width/2, height*33/48, width/18.0, 0, false);
  opc.ledStrip((3+2)*64 + 38-2, 18, width/2, height*35/48, width/18.0, 0, true);
  
  opc.ledStrip((6+0)*64 + 0, 18, width/2, height*37/48, width/18.0, 0, false);
  opc.ledStrip((6+0)*64 + 19, 18, width/2, height*39/48, width/18.0, 0, true);
  opc.ledStrip((6+0)*64 + 38, 18, width/2, height*41/48, width/18.0, 0, false);
  opc.ledStrip((6+1)*64 + 0, 18, width/2, height*43/48, width/18.0, 0, true);
  opc.ledStrip((6+1)*64 + 19, 18, width/2, height*45/48, width/18.0, 0, false);
  opc.ledStrip((6+1)*64 + 38, 18, width/2, height*47/48, width/18.0, 0, true);  
}

