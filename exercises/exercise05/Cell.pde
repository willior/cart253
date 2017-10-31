class Cell {

  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;

  int energyOffset;
  
  // variable for collision detection
  float areaSize = 10;
  
  color fill = color(255,0,0);
  
  Cell(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }
  
  void update() {
  
    if (energy == 0){
      return;
    }
    
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
  
    tx += 0.01;
    ty += 0.01;
  
    // wrap detection
    if (x < 0) {
      x += width;
    }
    else if (x > width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    }
    else if (y > height) {
      y -= height;
    }
    
    energy += moveEnergy;
    energy = constrain(energy,0,maxEnergy);
    energyOffset = maxEnergy-energy;
    
  }
  
  void collide(Cell other) {
    if (energy == 0 || other.energy == 0) {
      return;
    }
    
    // collision detection logic
    if ((x == other.x && y == other.y) || (x <= other.x + 10 && y <= other.y + 10) && (x >= other.x - 10 && y >= other.y - 10)){
      energy += collideEnergy;
      energy = constrain(energy,0,maxEnergy);
    }
  }
  
  void display() {
    fill((255-energyOffset), energyOffset, 0, energy);
    noStroke();
    ellipse(x,y,20,20);
  }
}