OPC opc;
PImage fade;
int numComets = 10;
ArrayList<Comet> comets = new ArrayList<Comet>();
ArrayList<Comet> babyComets = new ArrayList<Comet>();
// Animations

void setup()
{
  size(1260,480); // 126 pixels wide, 48 pixels tall 
  
  opc = new OPC(this, "127.0.0.1", 7890);
  LEDwall ledWall = new LEDwall(opc, 7, 2); // OPC, numHorizontalPanels, numVerticalPanels  
  
  fade = get(0,0,width,height);
  
  // Animation
  for (int i=0; i<numComets; i++) {
    Comet c = new Comet(random(width), random(height), 5, 5, random(10,21));
    comets.add(c);
  }
}

void draw()
{
  background(0);
  // Apply fade
  tint(255,255,255,220);
  //fade.resize(width*0.99, height*0.99);
  image(fade, 1, 1);
  noTint();
  
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

