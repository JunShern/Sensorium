OPC opc;
PImage dot;

void setup()
{
  size(600, 600);

  // Load a sample image
  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  //opc.ledGrid(index, stripLength, numStrips, x, y, ledSpacing, stripSpacing, angle, zigzag)
  opc.ledGrid(0*48, 12, 4, width/2, height*1/6, width/12.0, height/12.0, 0, true); // Channel 1  
  opc.ledGrid(1*48, 12, 4, width/2, height*3/6, width/12.0, height/12.0, 0, true); // Channel 2
  opc.ledGrid(2*48, 12, 4, width/2, height*5/6, width/12.0, height/12.0, 0, true); // Channel 3  
   
}

void draw()
{
  background(0);

  // Draw the image, centered at the mouse location
  float dotSize = height * 0.7;
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}

