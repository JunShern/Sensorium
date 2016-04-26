import SimpleOpenNI.*;

SimpleOpenNI kinect;

void setup() {
  size(640*2, 480);
  kinect = new SimpleOpenNI(this);
  
  kinect.enableDepth();
  kinect.enableRGB();
}

void draw() {
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  PImage depthImage = kinect.depthImage();
  PImage rgbImage = kinect.rgbImage();
  
  // Draw images
  image(depthImage, 0, 0);
  image(rgbImage, 640, 0);
}

void mousePressed() {
  color c = get(mouseX, mouseY); // SERIOUSLY? Processing you make things so simple :')
  println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));
  println("depth: " + brightness(c));
}

