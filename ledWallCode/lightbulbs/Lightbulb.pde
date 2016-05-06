
public class Lightbulb 
{
  int xpos;
  int ypos;
  
  Lightbulb(int xpos, int ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }

  void update() {
    this.jiggle(20);
  }  
  
  void drawLightbulb(int x, int y) {
    fill(255);
    noStroke();
    ellipse(x, y, 20, 20);
  }
  
  void jiggle(int amplitude) {
    int x = this.xpos;
    int y = this.ypos;
    if (brightness(get(this.xpos, this.ypos)) > 10) {
      x += random(-amplitude, amplitude);
      y += random(-amplitude, amplitude);
    }
    println(brightness(get(this.xpos, this.ypos)));
    this.drawLightbulb(x, y);
  }
}
 
