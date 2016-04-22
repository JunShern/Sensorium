OPC opc;
PImage dot;
  
import processing.video.*;

Capture cam;

void setup()
{
  size(160, 120);

  // Load a sample image
  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //opc.ledGrid(index, stripLength, numStrips, x, y, ledSpacing, stripSpacing, angle, zigzag)
  opc.ledGrid(0*64, 12, 4, width/2, height*1/6, width/12.0, height/12.0, 0, true); // Channel 0
  opc.ledGrid(1*64, 12, 4, width/2, height*3/6, width/12.0, height/12.0, 0, true); // Channel 1
  opc.ledGrid(2*64, 12, 4, width/2, height*5/6, width/12.0, height/12.0, 0, true); // Channel 2  

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i);
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[15]);
    
    //cam = new Capture(this,320,240,30);
    cam.start();     
  }

}

void draw()
{
  background(0);

  // Draw the image, centered at the mouse location
  float dotSize = height * 0.7;
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);



  if (cam.available() == true) {
    cam.read();
    //println("ddddddddddd");
  } else {
    //println("NOT AVAILABLE");
  }
  image(cam, 0, 0);
  
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
  filter(THRESHOLD);
  filter(GRAY);
  filter(INVERT);
  delay(1);
}

