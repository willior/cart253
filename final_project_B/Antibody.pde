// Antibody
//
// a class that defines antibody objects, which are released whenever/wherever the player clicks
// they heal cells they come into contact with and have the potential to revive dead cells
// however, they do not last long and cannot be healed themself

class Antibody {

  int maxEnergy = 255;
  int moveEnergy = -2;
  int collideEnergy;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 8;
  float x;
  float y;

  int energyOffset;

  int healSFXseed = 0;

  Antibody(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  void update() {
    
    if (bossApproach > 0){
      return;
    }

    // terminates the function if energy is less than 0
    if (energy <= 0) {
      return;
    }

    // behaviour for antibodies with energy remaining
    else if (energy > 0) {

      float vx = speed * (noise(tx) * 2 - 1);
      float vy = speed * (noise(ty) * 2 - 1);

      if (mouseX > x) {
        vx += 1;
      }
      if (mouseX < x) {
        vx -= 1;
      }
      if (mouseY > y) {
        vy += 1;
      }
      if (mouseY < y) {
        vy -= 1;
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

  void heal(Cell patient) {

    // collision detection logic
    if ((x == patient.x && y == patient.y) || (x <= patient.x + 8 && y <= patient.y + 8) && (x >= patient.x - 8 && y >= patient.y - 8)) {

      // sound picker for heal release
      // sound only plays if cell is dead and antibody is alive
      if ((patient.energy <= 0) && (energy > 0)) {
        if (healSFXseed == 0) {
          heal1.play();
        }
        if (healSFXseed == 1) {
          heal2.play();
        }
        if (healSFXseed == 2) {
          heal3.play();
        }
        if (healSFXseed == 3) {
          heal4.play();
        }

        // variable used to cycle sequentially through sound effects
        healSFXseed++;
        if (healSFXseed == 4) {
          healSFXseed = 0;
        }
      }

      // collideEnergy, how much energy the Antibody heals a Cell for, is determined by the Antibody's current remaining energy
      collideEnergy = energy;
      patient.energy += collideEnergy;
      patient.energy = constrain(energy, 0, maxEnergy);
      energy--;
    }
  }
  
  // display the antibodies
  void display() {
    fill(255, 255, 0, energy);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}