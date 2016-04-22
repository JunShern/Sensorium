  
import processing.video.*;

Capture cam;

void setup() {
  size(300,300);
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
    cam = new Capture(this, cameras[5]);
    
    //cam = new Capture(this,320,240,30);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    //println("ddddddddddd");
  } else {
    //println("NOT AVAILABLE");
  }
  image(cam, 0, 0);
  
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  filter(THRESHOLD);
  filter(GRAY);
  filter(INVERT);
  delay(1);
}
