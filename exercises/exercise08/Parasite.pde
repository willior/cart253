// Parasite
//
// a class that defines parasite objects, which drain energy from cells and become larger when they kill one

class Parasite {

  int drainEnergy = 20;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 8;
  float x;
  float y;

  float killCount = 0;
  float sizeOffset;
  
  float killSFXseed;

  color fill = color(0, 0, 255);

  Parasite(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void update() {
    
    // created a new variable, sizeOffset, to modulate both the parasite hitbox and size based off each parasite's kill count
    sizeOffset = killCount/4;
    
    // constrains the sizeOffset variable to remain within a reasonable range; otherwise, the parasites become too big and the game becomes impossible very quickly
    sizeOffset = constrain (sizeOffset,0,255);

    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;

    tx += 0.01;
    ty += 0.01;

    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }
  }

  void attack(Cell host) {

    if ((x == host.x && y == host.y) || (x <= host.x + (10+(sizeOffset/4)) && y <= host.y + (10+(sizeOffset/4)) && (x >= host.x - (10+(sizeOffset/4)) && y >= host.y - (10+(sizeOffset/4))))) {
      
      if (host.energy < 0) {
        return;
      }
      
        else {
        
        host.energy -= drainEnergy;
        host.energy = constrain(energy, 0, 255);
        
        if (host.energy == 0) {
          
          // picks a kill sound at random form the library
          killSFXseed = random(0, 9);
          if ((killSFXseed >= 0) && (killSFXseed <= 1)) {
            kill1.play();
          }
          if ((killSFXseed > 1) && (killSFXseed <= 2)) {
            kill2.play();
          }
          if ((killSFXseed > 2) && (killSFXseed <= 3)) {
            kill3.play();
          }
          if ((killSFXseed > 3) && (killSFXseed <= 4)) {
            kill4.play();
          }
          if ((killSFXseed > 4) && (killSFXseed <= 5)) {
            kill5.play();
          }
          if ((killSFXseed > 5) && (killSFXseed <= 6)) {
            kill6.play();
          }
          if ((killSFXseed > 6) && (killSFXseed <= 7)) {
            kill7.play();
          }
          if ((killSFXseed > 7) && (killSFXseed <= 8)) {
            kill8.play();
          }
          if ((killSFXseed > 8) && (killSFXseed <= 9)) {
            kill9.play();
          }
          
          killCount++;
          host.energy = -1;
        }
      }
    }
  }

  void display() {
    fill(fill, 96); 
    stroke(127, 0, 127);
    ellipseMode(CENTER);
    ellipse(x+15, y+15, 20+(sizeOffset), 20+(sizeOffset));
  }
}