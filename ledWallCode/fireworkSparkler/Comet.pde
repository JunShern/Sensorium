

public class Comet
{
  float cometX;
  float cometY;
  float velocityX;
  float velocityY;
  float maxSpeedX;
  float maxSpeedY;
  float cometRadius;
  
  Comet(float x, float y, float maxSpeedX, float maxSpeedY, float radius) {
    this.cometX = x;
    this.cometY = y;
    this.maxSpeedX = maxSpeedX;
    this.maxSpeedY = maxSpeedY;
    this.velocityX = random(-maxSpeedX, maxSpeedX);
    this.velocityY = random(-maxSpeedY, maxSpeedY);
    this.cometRadius = radius;
  } 
  
  void collision(int percentage) {
    if (this.cometX <= this.cometRadius || this.cometX >= width-this.cometRadius) {
      this.velocityX = -this.velocityX;
    }
    if (this.cometY <= this.cometRadius || this.cometY >= height-this.cometRadius) {
      this.velocityY = -this.velocityY;
    }
    if (random(100) > 100-percentage) {
      this.velocityY = -this.velocityY + random(-2,2);
      this.velocityY = constrain(this.velocityY, -maxSpeedY, maxSpeedY);
    }
    if (random(100) > 100-percentage) {
      this.velocityX = -this.velocityX + random(-2,2);
      this.velocityX = constrain(this.velocityX, -maxSpeedX, maxSpeedX);
    }
  }
  
  void gravitate(int x, int y) {
    this.velocityX = cometX-x;
    this.velocityY = cometY-y;
  }
  
  void update() {
    this.cometX += this.velocityX;
    this.cometX = constrain(this.cometX, this.cometRadius, width-this.cometRadius);
    this.cometY += this.velocityY;
    this.cometY = constrain(this.cometY, this.cometRadius, height-this.cometRadius);
    noStroke();
    fill(255);
    ellipse(this.cometX, this.cometY, this.cometRadius, this.cometRadius);
  }
  
  void supernova() {
    int numBabies = int(random(10, 20));
    for (int i=0; i< numBabies; i++) {
      Comet babyc = new Comet(this.cometX, this.cometY, 5, 5, random(this.cometRadius*1/4,this.cometRadius*2/4));
      babyComets.add(babyc);
    }
  }
  
}
