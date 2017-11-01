// Parasite
//
// a class that defines parasite objects, which drain energy from cells and become larger when they kill one

class Parasite {

  int drainEnergy = 20;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;
  
  int killCount = 0;

  color fill = color(0,0,255);

  Parasite(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }
  
  void update() {
    
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
  
    tx += 0.01;
    ty += 0.01;
    
    if (x < 0) {
      x += width;
    }
    else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    }
    else if (y >= height) {
      y -= height;
    }
  }
  
  void attack(Cell host) {

    if ((x == host.x && y == host.y) || (x <= host.x + (10) && y <= host.y + (10) && (x >= host.x - (10) && y >= host.y - (10)))) {
      host.energy -= drainEnergy;
      host.energy = constrain(energy,0,255);
      if (host.energy == 0) {
        killCount++;
      }
    }
  }

  void display() {
    fill(fill, 127); 
    stroke(127,0,127);
    ellipseMode(CORNER);
    ellipse(x+15, y+15, 20+(killCount/4), 20+(killCount/4));
  }
}