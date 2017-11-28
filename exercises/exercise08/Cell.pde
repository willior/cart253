// Cell
//
// a class that defines cell objects, which float around and can be influenced with mouse movement
// they slowly lose energy over time and gain a small amount of energy when colliding with other cells
// once killed, they can be resurrected by antibodies



class Cell {



  int maxEnergy = 255;
  float moveEnergy = -0.2;
  int collideEnergy = 10;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 10;
  float x;
  float y;
  float vx;
  float vy;

  int energyOffset;

  float killSFXseed;

  Cell(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  void update() {
    // draws a kill marker at the spot where the update function sees the Cell at 0 or less energy
    // terminates the function if energy is less than 0
    if (energy < 0) {
      strokeWeight(1);
      stroke(255, 0, 0);
      line(x-5, y-5, x+5, y+5);
      line(x-5, y+5, x+5, y-5);
      return;
    }

    // if a cell falls to 1 energy or below, the kill sound picker is run
    else if (energy <= 1) {

      // picks a kill sound effect at random from the library
      //killSFXseed = random(0, 9);
      //if ((killSFXseed >= 0) && (killSFXseed <= 1)) {
      //  kill1.play();
      //}
      //if ((killSFXseed > 1) && (killSFXseed <= 2)) {
      //  kill2.play();
      //}
      //if ((killSFXseed > 2) && (killSFXseed <= 3)) {
      //  kill3.play();
      //}
      //if ((killSFXseed > 3) && (killSFXseed <= 4)) {
      //  kill4.play();
      //}
      //if ((killSFXseed > 4) && (killSFXseed <= 5)) {
      //  kill5.play();
      //}
      //if ((killSFXseed > 5) && (killSFXseed <= 6)) {
      //  kill6.play();
      //}
      //if ((killSFXseed > 6) && (killSFXseed <= 7)) {
      //  kill7.play();
      //}
      //if ((killSFXseed > 7) && (killSFXseed <= 8)) {
      //  kill8.play();
      //}
      //if ((killSFXseed > 8) && (killSFXseed <= 9)) {
      //  kill9.play();
      //}

      // energy is ticked down once again in order to trigger the previous if statement (energy <= 0) on next update(), then breaks out of the function
      energy = -1;
      return;
    }

    // behaviour for cells with energy remaining
    else if (energy > 1) {

      vx = speed * (noise(tx) * 2 - 1) + ((mouseX) - (width/2)) / (width/10);
      vy = speed * (noise(ty) * 2 - 1) + ((mouseY) - (width/2)) / (width/10);

      if (mouseX > x) {
        vx += .5;
      }
      if (mouseX < x) {
        vx -= .5;
      }
      if (mouseY > y) {
        vy += .5;
      }
      if (mouseY < y) {
        vy -= .5;
      }

      // function to drain energy bar if mouse is pressed
      if (mousePressed == true) {
        bar.update();
      }

      x += vx;
      y += vy;

      tx += 0.01;
      ty += 0.01;

      // wrap detection
      if (x < 0) {
        x += width;
      } else if (x > width) {
        x -= width;
      }
      if (y < 0) {
        y += height;
      } else if (y > height) {
        y -= height;
      }

      // energy 
      energy += moveEnergy;
      energy = constrain(energy, 0, maxEnergy);
      energyOffset = maxEnergy-energy;

    }
  }

  // collision functions; breaks out if either Cell is dead
  void collide(Cell other) {
    if (energy <= 0 || other.energy <= 0) {
      return;
    }

    // collision detection logic
    if ((x == other.x && y == other.y) || (x <= other.x + 10 && y <= other.y + 10) && (x >= other.x - 10 && y >= other.y - 10)) {
      energy += collideEnergy;
      energy = constrain(energy, -1, maxEnergy);
    }
  }

  // display the cells
  void display() {
    fill((255-energyOffset), energyOffset, 0, energy);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}