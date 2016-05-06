import java.awt.image.BufferedImage;
import java.util.Arrays;
import SimpleOpenNI.*;

OPC opc;

SimpleOpenNI kinect;
int maxDistance = 3000; 

PImage orig;
PImage edgeImage;
PImage fade;
int REDUCE_FACTOR = 8; // Higher reduce factor increases the smoothing
CannyEdgeDetector detector = new CannyEdgeDetector();


int numComets = 10;
ArrayList<Comet> comets = new ArrayList<Comet>();
ArrayList<Comet> babyComets = new ArrayList<Comet>();

void setup()
{
  size(1260, 480); // 126 pixels wide, 48 pixels tall 

  // Kinect
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  // Edge detection
  detector.setLowThreshold(0.5f);
  detector.setHighThreshold(1f);

  // LED wall
  opc = new OPC(this, "127.0.0.1", 7890);
  LEDwall ledWall = new LEDwall(opc, 7, 2); // OPC, numHorizontalPanels, numVerticalPanels
  
  fade = get(0,0,width,height);
}

void draw()
{
  background(0);
  // Apply fade
  tint(255,255,255,220);
  //fade.resize(width*0.99, height*0.99);
  image(fade, 1, 1);
  noTint();
  
  // Capture
  kinect.update();
  PImage depthImage = kinect.depthImage();
  int[] depthValues = kinect.depthMap();

  // Thresholding
  depthImage.loadPixels();
  for (int i = 0; i < depthImage.width * depthImage.height; i++) {
    //println(depthImage.pixels[i]);
    if (depthValues[i] > maxDistance) { 
      depthImage.pixels[i] = color(0);
    }
  }

  // Edge detection
  PImage edgeImage;
  PImage depthCopy = createImage(depthImage.width, depthImage.height, RGB);
  depthCopy.copy(depthImage, 0, 0, depthImage.width, depthImage.height, 0, 0, 640, 480);
  depthCopy.resize(depthCopy.width/REDUCE_FACTOR, 0);
  detector.setSourceImage((java.awt.image.BufferedImage)depthCopy.getImage());
  detector.process();
  BufferedImage edges = detector.getEdgesImage();
  edgeImage = new PImage(edges);
  edgeImage.resize(edgeImage.width*48/edgeImage.height, 48); // Make the height fit, maintaining aspect ratio on width
  
  // Save image for averaging
  //PImage prevImage = createImage(
  // Draw image 
  edgeImage.loadPixels();
  int pixelHeight = height/48;//edgeImage.height;
  int pixelWidth = width/126;//edgeImage.width;
  for (int j=0; j<edgeImage.height; j++) {  
    for (int i=0; i<edgeImage.width; i++) {
      int index = i + j*edgeImage.width;
      fill(edgeImage.pixels[index]);
      //fill(255);
      ellipse(i*pixelWidth + pixelWidth/2, j*pixelHeight + pixelHeight/2, pixelWidth/2, pixelHeight/2);
    }
  }
  
  //edgeImage.resize(kinectW, kinectH);
  //image(edgeImage, 0,0);

  // Additional art
  ArrayList<Comet> deadComets = new ArrayList<Comet>();
  
  for (Comet c : comets) {
    c.update();
    c.collision(2); // 2% collision chance
    if (random(1000) > 998) {
      deadComets.add(c); // Flag comets as dead
      c.supernova();
      numComets--;
    }
  }
  
  
  // Comet offspring
  for (Comet c : babyComets) {
    c.update();
    c.collision(2); // 2% collision chance
    if (random(1000) > 950) deadComets.add(c); // Flag comets as dead, high infant mortality rate
  }
  
  // Remove dead comets
  for (Comet c : deadComets) {
    comets.remove(c);
    babyComets.remove(c);
  } // No need to remove from deadComets because it is a temporary variable
  
  // MOARRR
  if (random(100) > 96 || numComets < 5) {
    Comet c = new Comet(random(width), random(height), 5, 5, random(10,21));
    comets.add(c);
    numComets++;
  }
  fade = get(0,0,width,height);

}

void mousePressed() {
  int[] depthValues = kinect.depthMap();
  int clickIndex = mouseX + (mouseY * 640);
  maxDistance = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  println("New threshold : ", maxDistance);
}

