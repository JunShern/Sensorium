OPC opc;
PImage dot;

void setup()
{
  size(540, 720);
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  initLED();
} 

void draw()
{
  background(0);

  // Draw the image, centered at the mouse location
  rectMode(CENTER);
  rect(mouseX, mouseY, 120, 120); 
//  float dotSize = height * 0.5;
//  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);

}


void initLED() {
  opc.ledStrip((0+0)*64 + 0, 18, width/2, height*1/48, width/18.0, 0, false);
  opc.ledStrip((0+0)*64 + 19, 18, width/2, height*3/48, width/18.0, 0, true);
  opc.ledStrip((0+0)*64 + 38, 18, width/2, height*5/48, width/18.0, 0, false);
  opc.ledStrip((0+1)*64 + 0, 18, width/2, height*7/48, width/18.0, 0, true);
  opc.ledStrip((0+1)*64 + 19, 18, width/2, height*9/48, width/18.0, 0, false);
  opc.ledStrip((0+1)*64 + 38, 18, width/2, height*11/48, width/18.0, 0, true);
  opc.ledStrip((0+2)*64 + 0, 18, width/2, height*13/48, width/18.0, 0, false);
  opc.ledStrip((0+2)*64 + 19, 18, width/2, height*15/48, width/18.0, 0, true);
  opc.ledStrip((0+2)*64 + 38-2, 18, width/2, height*17/48, width/18.0, 0, false);
  
  opc.ledStrip((3+0)*64 + 0, 18, width/2, height*19/48, width/18.0, 0, true);
  opc.ledStrip((3+0)*64 + 19, 18, width/2, height*21/48, width/18.0, 0, false);
  opc.ledStrip((3+0)*64 + 38, 18, width/2, height*23/48, width/18.0, 0, true);
  opc.ledStrip((3+1)*64 + 0, 18, width/2, height*25/48, width/18.0, 0, false);
  opc.ledStrip((3+1)*64 + 19, 18, width/2, height*27/48, width/18.0, 0, true);
  opc.ledStrip((3+1)*64 + 38, 18, width/2, height*29/48, width/18.0, 0, false);
  opc.ledStrip((3+2)*64 + 0, 18, width/2, height*31/48, width/18.0, 0, true);
  opc.ledStrip((3+2)*64 + 19-2, 18, width/2, height*33/48, width/18.0, 0, false);
  opc.ledStrip((3+2)*64 + 38-2, 18, width/2, height*35/48, width/18.0, 0, true);
  
  opc.ledStrip((6+0)*64 + 0, 18, width/2, height*37/48, width/18.0, 0, false);
  opc.ledStrip((6+0)*64 + 19, 18, width/2, height*39/48, width/18.0, 0, true);
  opc.ledStrip((6+0)*64 + 38, 18, width/2, height*41/48, width/18.0, 0, false);
  opc.ledStrip((6+1)*64 + 0, 18, width/2, height*43/48, width/18.0, 0, true);
  opc.ledStrip((6+1)*64 + 19, 18, width/2, height*45/48, width/18.0, 0, false);
  opc.ledStrip((6+1)*64 + 38, 18, width/2, height*47/48, width/18.0, 0, true);  
}

