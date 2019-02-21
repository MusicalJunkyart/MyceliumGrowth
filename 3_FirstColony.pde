class FirstColony implements Variables {


  ArrayList<Mycelium> mycelia = new ArrayList<Mycelium>();
  ArrayList<Particle> particles = new ArrayList<Particle>();


  FirstColony() {

    //for (int i = 0; i < 2000; i++) {
    //  particles.add(new Particle());
    //}   
    
    for (int i = 0; i < 500; i++) {
      particles.add(new Particle(new PVector(width/2, height/2), width/8));
    }   
    for (int i = 0; i < 1000; i++) {
      particles.add(new Particle(new PVector(width/4, height/6), width/4));
      particles.add(new Particle(new PVector(3 * width/4, 2 * height/3), width/4));
    }

    Mycelium injection = new Mycelium(new PVector(width/2, height/2), new PVector(0, -1));
    mycelia.add(injection);
    Mycelium current = new Mycelium(injection);

    while (!closeEnough(current)) {                
      Mycelium temp = new Mycelium(current);
      mycelia.add(temp);
      current = temp;
    }
  }



  //Methods
  boolean closeEnough(Mycelium m) {

    for (Particle p : particles) {
      float distance = PVector.dist(m.position, p.position);
      if (distance < max_dist1) 
        return true;
    }
    return false;
  }


  void growFirstColony() {

    for (Particle p : particles) {
      Mycelium closest = null;
      PVector closestDir = null;
      float record = -1;

      for (Mycelium m : mycelia) {
        PVector direction = PVector.sub(p.position, m.position);
        float distance = direction.mag();

        if (distance < min_dist1) {
          p.reached();
          closest = null;
          break;
        } else if (distance > max_dist1) {
          //do nothing
        } else if (closest == null || distance < record) {
          closest = m;
          closestDir = direction;
          record =  distance;
        }
      }
      if (closest != null) {
        closestDir.normalize();
        closest.direction.add(closestDir);
        closest.count++;
      }
    }
    for (int i = particles.size() - 1; i >= 0; i--) {
      if (particles.get(i).reached)
        particles.remove(i);
    }
    for (int i = mycelia.size() - 1; i >= 0; i--) {
      Mycelium m = mycelia.get(i);

      if (m.count > 0) {
        PVector rand = PVector.random2D();
        rand.setMag(0.35);
        m.direction.add(rand);
        m.direction.normalize();

        Mycelium newM = new Mycelium(m);
        mycelia.add(newM);
        m.reset();
      }
    }
  }


  void showFirstColony() {

    for (Particle p : particles)
      p.show();

    for (int i = 0; i < mycelia.size(); i++) {
      Mycelium m = mycelia.get(i);

      if (m.parent != null) {         
        float sw = map(i, 1, mycelia.size(), 2, 0.1); //default 2, 0.1
        strokeWeight(sw);
        m.show();
      }
    }
  }
}
