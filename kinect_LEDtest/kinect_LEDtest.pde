OPC opc;
PImage dot;
int backgroundThreshold = 3000;  
import SimpleOpenNI.*;

SimpleOpenNI kinect;

void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //opc.ledGrid(index, stripLength, numStrips, x, y, ledSpacing, stripSpacing, angle, zigzag);
  opc.ledGrid(0*64, 12, 4, width/2, height*1/6, width/12.0, height/12.0, 0, true); // Channel 0
  opc.ledGrid(1*64, 12, 4, width/2, height*3/6, width/12.0, height/12.0, 0, true); // Channel 1
  opc.ledGrid(2*64, 12, 4, width/2, height*5/6, width/12.0, height/12.0, 0, true); // Channel 2  

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

