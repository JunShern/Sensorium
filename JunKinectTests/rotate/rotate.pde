import SimpleOpenNI.*;

SimpleOpenNI kinect;

void setup() {
  size(480, 640);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw() {
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  PImage depthImage = kinect.depthImage();
  //translate(0, 0);
  //translate(width/2,height/2);
  //rotate(PI*3/2);
  rotate(PI/2);
  rect(width/2, height/2, 50, 100);
  
  //translate(width,0);
  // Draw image
  //image(depthImage, 0, 0);
  
}

void mousePressed() {
  int[] depthValues = kinect.depthMap();
  int clickIndex = mouseX + (mouseY * 640);
  
  int millimeters = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  float inches = millimeters / 25.4;
  println("mm: ", millimeters, "  Inches: " + inches);
  println("");
}

