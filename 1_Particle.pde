class Particle {

  PVector position;
  boolean reached = false;

  Particle() {
    position = PVector.random2D();
    position.mult(random(width/2));
    position.x += width/2;
    position.y += height/2;
  }

  Particle(PVector position) {
    this.position = position.copy();
  }

  Particle(PVector mean, float deviation) {
    spawn(mean, deviation);
  }



  //Methods
  void reached() {
    reached = true;
  }

  void spawn(PVector mean, float deviation) {
    position = PVector.random2D();
    position.mult(abs(deviation * randomGaussian()));
    position.add(mean);
  }

  void show() {
    fill(255, 223, 128, 100);
    noStroke();
    ellipse(position.x, position.y, 4, 4);
  }
}
