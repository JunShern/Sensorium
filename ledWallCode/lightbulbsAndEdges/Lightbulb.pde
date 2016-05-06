
public class Lightbulb 
{
  int xpos;
  int ypos;
  
  Lightbulb(int xIndex, int yIndex) {
    this.xpos = pixelCoordinateX(xIndex);
    this.ypos = pixelCoordinateY(yIndex);
  }

  void update() {
    this.jiggle(20);
  }  
  
  void drawLightbulb(int x, int y) {
    fill(255);
    noStroke();
    ellipse(x, y, 10, 10);
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
  
  int pixelCoordinateX(int x) {
    int pixelWidth = width/126;//edgeImage.width;
    return pixelWidth/2 + pixelWidth * x;
  }
  
  int pixelCoordinateY(int y) {
    int pixelHeight = height/48;//edgeImage.height;
    return pixelHeight/2 + pixelHeight * y;
  }

  void rebirth() {
    
  }
}
 
