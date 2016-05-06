OPC opc;

void setup()
{
  size(1260,480); // 126 pixels wide, 48 pixels tall 
  
  opc = new OPC(this, "127.0.0.1", 7890);
  LEDwall ledWall = new LEDwall(opc, 7, 2); // OPC, numHorizontalPanels, numVerticalPanels  
}

void draw()
{
  background(0);
  rect(mouseX, mouseY, 60, 60);
}

