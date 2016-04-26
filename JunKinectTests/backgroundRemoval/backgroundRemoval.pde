import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
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
  if (xArray.size() > 10) {  
    xArray.remove(0);
    yArray.remove(0);
  } 
  drawCircles();
}

void drawCircles() {
  noStroke();
  for (int i=0; i<xArray.size(); i++) {
    fill(0,250,250,155+i*10);
    ellipse(xArray.get(i), yArray.get(i), 10+i, 10+i);
  }
}
