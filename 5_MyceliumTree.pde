
boolean click = false;
SecondColony colony;

void setup() {

  fullScreen();
  colony = new SecondColony();
}

void draw() {
  background(26);

  colony.growFirstColony();
  //colony.growSecondColony();
  colony.walkSecondColony();

  colony.showFirstColony();
  colony.showSecondColony();


  //saveFrame("output/frames_####.png");
}
