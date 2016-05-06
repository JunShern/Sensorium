import SimpleOpenNI.*;
SimpleOpenNI kinect;
OPC opc;

void setup()
{
  size(1260,480); // 126 pixels wide, 48 pixels tall 
  
  opc = new OPC(this, "127.0.0.1", 7890);
  LEDwall ledWall = new LEDwall(opc, 7, 2); // OPC, numHorizontalPanels, numVerticalPanels
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  //kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_NONE); 
}

void draw()
{
  background(0);
  
  kinect.update();
  image(kinect.depthImage(), 0, 0);
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  for (int i=0; i<userList.size(); i++) { 
    int userId = userList.get(i);
    PVector position = new PVector();
    kinect.getCoM(userId, position); 
    kinect.convertRealWorldToProjective(position, position);
    fill(255, 0, 0);
    ellipse(position.x, position.y, 25,25);
    textSize(40);
    text(userId, position.x, position.y);
  }
}

