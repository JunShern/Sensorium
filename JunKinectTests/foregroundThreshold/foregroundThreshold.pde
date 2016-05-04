import SimpleOpenNI.*;

SimpleOpenNI kinect;
int count = 1;
int maxDistance = 3000;

void setup() {
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  
}

void draw() {
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  PImage depthImage = kinect.depthImage();
  PImage copyImage;
  int[] depthValues = kinect.depthMap();
  
  depthImage.loadPixels();
  for (int i = 0; i < width * height; i++) {
    //println(depthImage.pixels[i]);
    if (depthValues[i] > maxDistance) { 
      depthImage.pixels[i] = color(0);
    }
  }
  // Draw image
  image(depthImage, 0, 0);
}

void mousePressed() {
  int[] depthValues = kinect.depthMap();
  int clickIndex = mouseX + (mouseY * 640);
  
  maxDistance = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  float inches = maxDistance / 25.4;
  println("mm: ", maxDistance, "  Inches: " + inches);
  println("");
  //println(depthImage.pixels[]);
}

