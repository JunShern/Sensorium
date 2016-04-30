OPC opc;
int i=0;

void setup()
{
  opc = new OPC(this, "127.0.0.1", 7890);
  //frameRate(10);
//  colorMode(HSB, 100);
}

void draw()
{
  // RAINBOW FADE!!!!!
  for (i = 0*64; i < 8 * 64; i++) {
    opc.setPixel(i, color(118)); // 250 Lux
  }
  //float hue = (millis() * 0.01 + i * 2.0) % 100; 
  opc.writePixels();
  
  //opc.setPixel(i, color(0, 0, 0));
  //opc.writePixels();
//  opc.setPixel(3*64, color(255, 255, 255));
//  opc.writePixels();
}
