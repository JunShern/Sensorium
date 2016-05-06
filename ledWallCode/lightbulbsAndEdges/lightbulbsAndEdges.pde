import java.awt.image.BufferedImage;
import java.util.Arrays;
import SimpleOpenNI.*;

OPC opc;

SimpleOpenNI[] kinects;

int numLightbulbs = 50;
//Lightbulb[] lightbulbs = new Lightbulb[numLightbulbs];
ArrayList<Lightbulb> lightbulbs = new ArrayList<Lightbulb>();

int numKinects = 2;
int maxDistance = 3000; 

PImage orig;
PImage edgeImage;
PImage fade;
int REDUCE_FACTOR = 8; // Higher reduce factor increases the smoothing
CannyEdgeDetector detector = new CannyEdgeDetector();

void setup()
{
  size(1260, 480); // 126 pixels wide, 48 pixels tall 

  // Kinect
  kinects = new SimpleOpenNI[numKinects];
  for (int i=0; i<numKinects; i++) {
    kinects[i] = new SimpleOpenNI(i, this);
    kinects[i].enableDepth();
  }

  // Edge detection
  detector.setLowThreshold(0.5f);
  detector.setHighThreshold(1f);
  
  // LED wall
  opc = new OPC(this, "127.0.0.1", 7890);
  LEDwall ledWall = new LEDwall(opc, 7, 2); // OPC, numHorizontalPanels, numVerticalPanels
  
  // Lightbulbs 
  for (int i=0; i<numLightbulbs; i++) {
    int xIndex = int(random(90,125));
    int yIndex = int(random(0,47));
    if (random(100) > 40) {
      xIndex = int(random(60,125));
      yIndex = int(random(0,47));
      if (random(100) > 40) {
        xIndex = int(random(40,125));
        yIndex = int(random(0,47));
      }
    }
    Lightbulb l = new Lightbulb(xIndex, yIndex);
    lightbulbs.add(l);
  }
  
  fade = get(0,0,width,height);
}

void draw()
{
  background(0);
  // Apply fade
  tint(255,255,255,220);
  //fade.resize(width*0.99, height*0.99);
  image(fade, 0, 0);
  noTint();
  
  for (int i=0; i<numKinects; i++) {
    handleKinect(kinects[i], i*width/2, 0);
  }
  
  //edgeImage.resize(kinectW, kinectH);
  //image(edgeImage, 0,0);
  // Lightbulbs
  for (Lightbulb l : lightbulbs) {  
    l.update();
    // Fading lightbulbs
    int x = int(random(90,125));
    int y = int(random(0,47));
    if (random(1000) > 997) {
      if (random(100) > 40) {
        x = int(random(60,125));
        y = int(random(0,47));
        if (random(100) > 40) {
          x = int(random(40,125));
          y = int(random(0,47));
        }
      }
      l.xpos = pixelCoordinateX(x); 
      l.ypos = pixelCoordinateY(y);
    }
  }
  
  fade = get(0,0,width,height);
}

void mousePressed() {
  int[] depthValues;
  int clickIndex;
  if (mouseX < width/2) {
    depthValues = kinects[0].depthMap();
    clickIndex = mouseX + (mouseY * 640);
  } else {
    depthValues = kinects[1].depthMap();
    clickIndex = mouseX + (mouseY * 640);
  }
  maxDistance = depthValues[clickIndex]; // depthMap gave us values in (close to) mm!
  println("New threshold : ", maxDistance);
  
}

void handleKinect(SimpleOpenNI kinect, int xpos, int ypos) {
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
  int offsetX = 7;
  int offsetY = 7;
  edgeImage = edgeImage.get(offsetX, offsetY, edgeImage.width-2*offsetX, edgeImage.height-2*offsetY); // Crop the image - dead space created at edges due to gaussian kernel 
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
      //color px = edgeImage.pixels[index];
      if (brightness(edgeImage.pixels[index]) > 10) {
        if (random(width) > 3*(xpos + i*pixelWidth + pixelWidth/2)/2) {
          fill(color(200));
        } else {
          fill(color(11));
        }
      } else {
        fill(color(0));
      }
      //fill(edgeImage.pixels[index]);
      ellipse(xpos + i*pixelWidth + pixelWidth/2, j*pixelHeight + pixelHeight/2, pixelWidth/2, pixelHeight/2);
    }
  }
}

int pixelCoordinateX(int x) {
  int pixelWidth = width/126;//edgeImage.width;
  return pixelWidth/2 + pixelWidth * x;
}

int pixelCoordinateY(int y) {
  int pixelHeight = height/48;//edgeImage.height;
  return pixelHeight/2 + pixelHeight * y;
}
