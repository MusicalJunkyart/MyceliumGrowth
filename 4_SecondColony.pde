class SecondColony extends FirstColony {

  ArrayList<Mycelium> branches = new ArrayList<Mycelium>();
  ArrayList<Particle> attractors = new ArrayList<Particle>();
  ArrayList<Mycelium> heads = new ArrayList<Mycelium>();


  SecondColony() {
    super();
  }

  //Methods
  void growSecondColony() {

    spawnAttractors();

    for (Mycelium m : mycelia) {
      if (m.offspring == null)
        branches.add(m);
    }

    for (Particle a : attractors) {
      Mycelium closest = null;
      PVector closestDir = null;
      float record = -1;

      for (Mycelium b : branches) {
        PVector direction = PVector.sub(a.position, b.position);
        float distance = direction.mag();

        if (distance < min_dist2) {
          a.reached();
          closest = null;
          break;
        } else if (distance > max_dist2) {
          //do nothing
        } else if (closest == null || distance < record) {
          closest = b;
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

    for (int i = attractors.size() - 1; i >= 0; i--) {
      if (attractors.get(i).reached)
        attractors.remove(i);
    }

    for (int i = branches.size() - 1; i >= 0; i--) {
      Mycelium b = branches.get(i);

      if (b.count > 0) {
        PVector rand = PVector.random2D();
        rand.setMag(0.3);
        b.direction.add(rand);
        b.direction.normalize();

        Mycelium newM = new Mycelium(b);
        mycelia.add(newM);
        branches.remove(b);
        b.reset();
      }
    }
  }


  float time = 0;

  void spawnAttractors() {

    for (int i = 0; i < 20; i++) {
      PVector position = PVector.random2D();
      position.mult(random(time, 2 * time));
      position.x += width/2;
      position.y += height/2;

      float min = width;
      for (Mycelium m : mycelia) {
        float distance = PVector.dist(position, m.position);
        if (distance < min)
          min = distance;
      }
      if (min < min_dist2) {
        continue;
      }

      attractors.add(new Particle(position));
    }
    time += 0.5;
  }


  float dtime = 0;

  void walkSecondColony() {

    branches.clear();

    for (Mycelium m : mycelia) {
      float distance = PVector.dist(m.position, new PVector(width/2, height/2));

      if (m.offspring == null && int(random(0)) == 0 && distance > dtime && distance < 2 * dtime)
        branches.add(m);
    }

    for (int i = branches.size() - 1; i >= 0; i--) {
      Mycelium b = branches.get(i);

      for (Mycelium m : mycelia) {
        PVector check = new PVector(b.position.x + b.direction.x, b.position.y + b.direction.y);
        float distance = PVector.dist(m.position, check);

        if (distance < 0.9999) {           //Very sensitive default 0.9999
          branches.remove(b);
          break;
        }
      }
    }


    for (int i = branches.size() - 1; i >= 0; i--) {
      Mycelium b = branches.get(i);


      PVector rand = PVector.random2D();
      rand.normalize();
      rand.setMag(0.2);
      b.direction.add(rand);
      b.direction.normalize();

      b.step = 2;
      Mycelium newM = new Mycelium(b);
      mycelia.add(newM);
      b.reset();
    }

    dtime += 1;
  }



  void showSecondColony() {

    heads.clear();
    for (Mycelium m : mycelia) {
      if (m.offspring == null)
        heads.add(m);
    }

    for (int i = 1; i < heads.size(); i++) {
      Mycelium b = heads.get(i);

      noStroke();
      fill(100, 100, 255, 100);
      ellipse(b.position.x, b.position.y, 4, 4);
    }

    for (Particle a : attractors) {      
      noStroke();
      fill(100, 220, 100);
      ellipse(a.position.x, a.position.y, 3, 3);
    }
  }
}
