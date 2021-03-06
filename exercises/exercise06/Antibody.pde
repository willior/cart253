// Antibody
//
// a class that defines antibody objects, which are released whenever/wherever the player clicks
// they heal cells they come into contact with and have the potential to revive dead cells
// however, they do not last long and cannot be healed themself

class Antibody {
  
  int maxEnergy = 255;
  float moveEnergy = -2;
  int collideEnergy = 32;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;
  
  float vx;
  float vy;

  int energyOffset;

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
    
    // behaviour for antibodies with energy remaining
    else if (energy > 0) {
    
    vx = speed * (noise(tx) * 2 - 1);
    vy = speed * (noise(ty) * 2 - 1);
    
    bounce();
    
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
  
    // CHANGED: commented out wrap detection
    // wrap detection
    //if (x < 0) {
    //  x += width;
    //}
    //else if (x > width) {
    //  x -= width;
    //}
    //if (y < 0) {
    //  y += height;
    //}
    //else if (y > height) {
    //  y -= height;
    //}
    
    // energy 
    energy += moveEnergy;
    energy = constrain(energy,0,maxEnergy);
    energyOffset = maxEnergy-energy;
    }
  }
  void bounce() {
    // Check the left and right
    if (x - size/2 < 0 || x + size/2 > width) {
      // Bounce on the x-axis
      vx = -vx;
    }

    // Check the top and bottom
    if (y - size/2 < 0 || y + size/2 > height) {
      // Bounce on the y-axis
      vy = -vy;
    }

    // Make sure the Cell isn't off the edge
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }
  
  void heal(Cell patient) {
    
    // collision detection logic
    if ((x == patient.x && y == patient.y) || (x <= patient.x + 10 && y <= patient.y + 10) && (x >= patient.x - 10 && y >= patient.y - 10)){
      patient.energy += collideEnergy;
      patient.energy = constrain(energy,0,maxEnergy);
    }
  }
  
  void display() {
    fill(255, 255, 0, energy);
    noStroke();
    ellipse(x,y,10,10);
  }
}