OPC opc;

import java.awt.image.BufferedImage;
import java.util.Arrays;
import SimpleOpenNI.*;

SimpleOpenNI kinect;

PImage orig;
PImage changed;
int REDUCE_FACTOR = 7;
CannyEdgeDetector detector = new CannyEdgeDetector();


void setup()
{
  size(640,480); 
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  detector.setLowThreshold(0.5f);
  detector.setHighThreshold(1f);

  opc = new OPC(this, "127.0.0.1", 7890);
  initLED1();
  initLED2();
}

void draw()
{
  kinect.update(); // Get fresh data from the Kinect, depending on what has be enable()-ed
  
  // Capture
  println(kinect.depthWidth());
  PImage depthImage = kinect.depthImage();
  int[] depthValues = kinect.depthMap();
  PImage rgbImage = kinect.rgbImage();
  PImage changed;
  
  // Draw images
    //image(orig, 0,0, width, height);
  
  depthImage.loadPixels();
  for (int i = 0; i < width * height; i++) {
    //println(depthImage.pixels[i]);
    if (depthValues[i] > 4000) { 
      depthImage.pixels[i] = color(0);
    }
  }
  
  PImage depthCopy = createImage(width, height, RGB);
  depthCopy.copy(depthImage, 0, 0, width, height ,0, 0, 640, 480);
  depthCopy.resize(width/REDUCE_FACTOR, 0);

  detector.setSourceImage((java.awt.image.BufferedImage)depthCopy.getImage());
  detector.process();
  BufferedImage edges = detector.getEdgesImage();
  changed = new PImage(edges);
  changed.resize(width, height);
  image(changed, 0,0);

}

void initLED1() {
  opc.ledStrip((0+0)*64 + 0, 18, width/4, height*1/48, width/36.0, 0, false);
  opc.ledStrip((0+0)*64 + 19, 18, width/4, height*3/48, width/36.0, 0, true);
  opc.ledStrip((0+0)*64 + 38, 18, width/4, height*5/48, width/36.0, 0, false);
  opc.ledStrip((0+1)*64 + 0, 18, width/4, height*7/48, width/36.0, 0, true);
  opc.ledStrip((0+1)*64 + 19, 18, width/4, height*9/48, width/36.0, 0, false);
  opc.ledStrip((0+1)*64 + 38, 18, width/4, height*11/48, width/36.0, 0, true);
  opc.ledStrip((0+2)*64 + 0, 18, width/4, height*13/48, width/36.0, 0, false);
  opc.ledStrip((0+2)*64 + 19, 18, width/4, height*15/48, width/36.0, 0, true);
  opc.ledStrip((0+2)*64 + 38-2, 18, width/4, height*17/48, width/36.0, 0, false);
  
  opc.ledStrip((3+0)*64 + 0, 18, width/4, height*19/48, width/36.0, 0, true);
  opc.ledStrip((3+0)*64 + 19, 18, width/4, height*21/48, width/36.0, 0, false);
  opc.ledStrip((3+0)*64 + 38, 18, width/4, height*23/48, width/36.0, 0, true);
  opc.ledStrip((3+1)*64 + 0, 18, width/4, height*25/48, width/36.0, 0, false);
  opc.ledStrip((3+1)*64 + 19, 18, width/4, height*27/48, width/36.0, 0, true);
  opc.ledStrip((3+1)*64 + 38, 18, width/4, height*29/48, width/36.0, 0, false);
  opc.ledStrip((3+2)*64 + 0, 18, width/4, height*31/48, width/36.0, 0, true);
  opc.ledStrip((3+2)*64 + 19-2, 18, width/4, height*33/48, width/36.0, 0, false);
  opc.ledStrip((3+2)*64 + 38-2, 18, width/4, height*35/48, width/36.0, 0, true);
  
  opc.ledStrip((6+0)*64 + 0, 18, width/4, height*37/48, width/36.0, 0, false);
  opc.ledStrip((6+0)*64 + 19, 18, width/4, height*39/48, width/36.0, 0, true);
  opc.ledStrip((6+0)*64 + 38, 18, width/4, height*41/48, width/36.0, 0, false);
  opc.ledStrip((6+1)*64 + 0, 18, width/4, height*43/48, width/36.0, 0, true);
  opc.ledStrip((6+1)*64 + 19, 18, width/4, height*45/48, width/36.0, 0, false);
  opc.ledStrip((6+1)*64 + 38, 18, width/4, height*47/48, width/36.0, 0, true);  
}

void initLED2() {
  opc.ledStrip(513+(0+0)*64 + 0, 18, width*3/4, height*1/48, width/36.0, 0, false);
  opc.ledStrip(513+(0+0)*64 + 19, 18, width*3/4, height*3/48, width/36.0, 0, true);
  opc.ledStrip(513+(0+0)*64 + 38, 18, width*3/4, height*5/48, width/36.0, 0, false);
  opc.ledStrip(513+(0+1)*64 + 0, 18, width*3/4, height*7/48, width/36.0, 0, true);
  opc.ledStrip(513+(0+1)*64 + 19, 18, width*3/4, height*9/48, width/36.0, 0, false);
  opc.ledStrip(513+(0+1)*64 + 38, 18, width*3/4, height*11/48, width/36.0, 0, true);
  opc.ledStrip(513+(0+2)*64 + 0, 18, width*3/4, height*13/48, width/36.0, 0, false);
  opc.ledStrip(513+(0+2)*64 + 19, 18, width*3/4, height*15/48, width/36.0, 0, true);
  opc.ledStrip(513+(0+2)*64 + 38-2, 18, width*3/4, height*17/48, width/36.0, 0, false);
  
  opc.ledStrip(513+(3+0)*64 + 0, 18, width*3/4, height*19/48, width/36.0, 0, true);
  opc.ledStrip(513+(3+0)*64 + 19, 18, width*3/4, height*21/48, width/36.0, 0, false);
  opc.ledStrip(513+(3+0)*64 + 38, 18, width*3/4, height*23/48, width/36.0, 0, true);
  opc.ledStrip(513+(3+1)*64 + 0, 18, width*3/4, height*25/48, width/36.0, 0, false);
  opc.ledStrip(513+(3+1)*64 + 19, 18, width*3/4, height*27/48, width/36.0, 0, true);
  opc.ledStrip(513+(3+1)*64 + 38, 18, width*3/4, height*29/48, width/36.0, 0, false);
  opc.ledStrip(513+(3+2)*64 + 0, 18, width*3/4, height*31/48, width/36.0, 0, true);
  opc.ledStrip(513+(3+2)*64 + 19-2, 18, width*3/4, height*33/48, width/36.0, 0, false);
  opc.ledStrip(513+(3+2)*64 + 38-2, 18, width*3/4, height*35/48, width/36.0, 0, true);
  
  opc.ledStrip(513+(6+0)*64 + 0, 18, width*3/4, height*37/48, width/36.0, 0, false);
  opc.ledStrip(513+(6+0)*64 + 19, 18, width*3/4, height*39/48, width/36.0, 0, true);
  opc.ledStrip(513+(6+0)*64 + 38, 18, width*3/4, height*41/48, width/36.0, 0, false);
  opc.ledStrip(513+(6+1)*64 + 0, 18, width*3/4, height*43/48, width/36.0, 0, true);
  opc.ledStrip(513+(6+1)*64 + 19, 18, width*3/4, height*45/48, width/36.0, 0, false);
  opc.ledStrip(513+(6+1)*64 + 38, 18, width*3/4, height*47/48, width/36.0, 0, true);  
}

// The code below is taken from "http://www.tomgibara.com/computer-vision/CannyEdgeDetector.java" 
// I have stripped the comments for conciseness

