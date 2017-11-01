class Antibody {
  
  int maxEnergy = 255;
  float moveEnergy = -1;
  int collideEnergy = 50;
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
  
  color fill = color(255,255,0);
  
  Antibody(int tempX, int tempY, int tempSize) {
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
    
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    
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
  
  void heal(Cell patient) {
    
    // collision detection logic
    if ((x == patient.x && y == patient.y) || (x <= patient.x + 10 && y <= patient.y + 10) && (x >= patient.x - 10 && y >= patient.y - 10)){
      patient.energy += collideEnergy;
      patient.energy = constrain(energy,0,maxEnergy);
    }
  }
  
  void display() {
    fill((255), 255, 0, energy);
    noStroke();
    ellipse(x,y,20,20);
  }
}