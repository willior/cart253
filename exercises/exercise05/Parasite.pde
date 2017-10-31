class Parasite {

  int drainEnergy = 50;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;

  color fill = color(0,0,255);

  // Parasite(tempX, tempY, tempSize)
  //
  // Set up the Parasite with the specified location and size
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

    if ((x == host.x && y == host.y) || (x <= host.x + 10 && y <= host.y + 10) && (x >= host.x - 10 && y >= host.y - 10)) {
      // Decreases that Griddie's energy
      host.energy -= drainEnergy;
      // Constrain the energy level to be within bounds
      host.energy = constrain(energy,0,255);
    }
  }

  void display() {
    fill(fill, 127); 
    stroke(127,0,127);
    ellipseMode(CORNER);
    ellipse(x+15, y+15, 30, 30);
  }
}