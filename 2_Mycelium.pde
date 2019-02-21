class Mycelium {

  Mycelium parent;          
  Mycelium offspring;
  PVector position;          
  PVector direction;         

  int count = 0;   
  float step = 5;            
  PVector saveDir;

  Mycelium(PVector position, PVector direction) {

    this.position = position.copy();
    this.direction = direction.copy();
    saveDir = direction.copy();

    parent = null;
    offspring = null;
  }

  Mycelium(Mycelium parent) {

    position = parent.next();
    direction = parent.direction.copy();
    saveDir = direction.copy();

    this.parent = parent;
    parent.offspring = this;
  }

  //Methods
  PVector next() {
    PVector stepDir = PVector.mult(direction, step);
    PVector next = PVector.add(position, stepDir);
    return next;
  }

  void reset() {
    count = 0;
    direction = saveDir.copy();
  }

  void show() {
    if (parent == null) 
      return;
    stroke(170);
    line(position.x, position.y, parent.position.x, parent.position.y);
  }
}
