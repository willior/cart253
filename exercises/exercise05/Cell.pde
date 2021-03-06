// Cell
//
// a class that defines cell objects, which float around and can be influenced with mouse movement
// they slowly lose energy over time and gain a small amount of energy when colliding with other cells
// once killed, they can be resurrected by antibodies

class Cell {
  
  int maxEnergy = 255;
  float moveEnergy = -.2;
  int collideEnergy = 10;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;

  int energyOffset;
  
  Cell(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }
  
  void update() {
    
    // terminates the function if energy is less than 0
    if (energy <= 0) {
      return;
    }
    
    if (energy == 0) {
      energy--;
      return;
    }
    
    // behaviour for cells with energy remaining
    else if (energy > 0) {
    
    float vx = speed * (noise(tx) * 2 - 1) + ((mouseX) - (width/2)) / (width/10);
    float vy = speed * (noise(ty) * 2 - 1) + ((mouseY) - (width/2)) / (width/10);
    
    if (mouseX > x){
      vx += 1;
    }
    if (mouseX < x){
      vx -= 1;
    }
    if (mouseY > y){
      vy += 1;
    }
    if (mouseY < y){
      vy -= 1;
    }
    
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
    
    // energy 
    energy += moveEnergy;
    energy = constrain(energy,0,maxEnergy);
    energyOffset = maxEnergy-energy;
    }
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