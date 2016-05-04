import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;
IntList xArray;
IntList yArray;
int maxArrayLength = 15;

void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  // Init arrays
  xArray = new IntList();
  yArray = new IntList();
}

void draw() {
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Find closest -> smallest depth value
  closestValue = 8000;
  int[] depthValues = kinect.depthMap();
  for (int y=0; y<480; y++) {
    for (int x=0; x<640; x++) {
      int index = x + y*640;
      int currentDepthValue = depthValues[index];
      
      if (currentDepthValue > 0 && currentDepthValue < closestValue) {
        closestValue = currentDepthValue; // update new winner
        closestX = x;
        closestY = y;
      }
    }
  }
  
  // Capture
  //PImage depthImage = kinect.depthImage();
  
  // Draw image
  image(kinect.rgbImage(), 0, 0);
  
  // Update arrays
  xArray.append(closestX);
  yArray.append(closestY);
  if (xArray.size() > maxArrayLength) {  
    xArray.remove(0);
    yArray.remove(0);
  } 
  drawCircles();
}

void drawCircles() {
  for (int i=0; i<xArray.size(); i++) {
    int alphaVal = (255-10*maxArrayLength)+i*maxArrayLength;
    fill(0,250,250,alphaVal);
    if (i+1 < xArray.size()) {
      stroke(0,250,250,alphaVal);
      strokeWeight(1);
      line(xArray.get(i), yArray.get(i), xArray.get(i+1), yArray.get(i+1));
    }
    noStroke();
    int radius = constrain(20-maxArrayLength+i, 0, 20);
    ellipse(xArray.get(i), yArray.get(i), radius, radius);
  }
}
