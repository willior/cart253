// Cell
//
// a class that defines cell objects, which float around and can be influenced with mouse movement
// they slowly lose energy over time and gain a small amount of energy when colliding with other cells
// once killed, they can be resurrected by antibodies



class Cell {



  int maxEnergy = 255;
  float moveEnergy = -0.2;
  int collideEnergy = 16;
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

  Cell(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  void update() {
    
    if (bossApproach > 0){
      return;
    }
    
    // draws a kill marker at the spot where the update function sees the Cell at 0 or less ("confirmed dead")
    // makes sure the cell's energy is below 0 ("confirmed dead") so that it no longer is capable of feeding a parasite before breaking out of the function
    if (energy <= 0) {
      strokeWeight(1);
      stroke(255, 0, 0, 127);
      line(x-5, y-5, x+5, y+5);
      line(x-5, y+5, x+5, y-5);
      energy = -1;
      return;
    }

    // behaviour for cells with energy remaining
    else if (energy > 0) {

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

      // drains cell energy naturally
      energy += moveEnergy;
      
      // constrains energy to not fall below 0
      // if it does land at 0, this allows it to be eaten by a parasite in range, as parasites ignore "confirmed dead" (energy < 0) cell "corpses"
      // however, if a parasite does not eat it, it will most likely die naturally anyway
      energy = constrain(energy, 0, maxEnergy);
      
      // updates the energyOffset variable, used to colour the Cells
      energyOffset = maxEnergy-energy;
    }
  }

  // collision functions; breaks out if either Cell is confirmed dead
  void collide(Cell other) {
    if (energy <= 0) {
      return;
    }

    // collision detection logic
    if ((x == other.x && y == other.y) || (x <= other.x + 20 && y <= other.y + 20) && (x >= other.x - 20 && y >= other.y - 20)) {
      energy += collideEnergy;
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display the cells
  void display() {
    fill((255-energyOffset), energyOffset, 0, energy);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}