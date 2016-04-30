OPC opc;
PImage dot;

void setup()
{
  size(540, 720);
  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  initLED();
  background(255);
  brushes = new ArrayList<Brush>();
  for (int i = 0; i < 50; i++) {
    brushes.add(new Brush());
  }
} 

void draw()
{
  //background(0);

  // Draw the image, centered at the mouse location
  rectMode(CENTER);
  rect(mouseX, mouseY, 120, 120); 
//  float dotSize = height * 0.5;
//  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);

  for (Brush brush : brushes) {
    brush.paint();
  }
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

void mouseClicked() {
  setup();
}
 
class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;
 
  Brush() {
    angle = random(TWO_PI);
    x = random(width);
    y = random(height);
    clr = color(random(255), random(255), random(255), 5);
    components = new int[2];
    for (int i = 0; i < 2; i++) {
      components[i] = int(random(1, 5));
    }
  }
 
  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.5, 1);
 
    fill(clr);
    noStroke();   
 
    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1);
      float v = random(0.85, 1);
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);
 
    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }
 
    x += 2 * cos(angle);
    y += 2 * sin(angle);
    angle += random(-0.15, 0.15);
  }
}

