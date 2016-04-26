import SimpleOpenNI.*;

SimpleOpenNI kinect;

void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw() {
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  PImage depthImage = kinect.depthImage();
  
  // Draw image
  image(depthImage, 0, 0);
}

void mousePressed() {
  int[] depthValues = kinect.depthMap();
  int clickIndex = mouseX + (mouseY * 640);
  
  int millimeters = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  float inches = millimeters / 25.4;
  println("mm: ", millimeters, "  Inches: " + inches);
  println("");
}

