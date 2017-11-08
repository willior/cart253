// Parasite
//
// a class that defines parasite objects, which drain energy from cells and become larger when they kill one

class Parasite {

  int drainEnergy = 1000;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;
  
  float vx;
  float vy;
  
  int killCount = 0;
  float hitbox = 10;

  color fill = color(127,0,255);

  Parasite(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }
  
  void update() {
    
    vx = speed * (noise(tx) * 2 - 1);
    vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
  
    tx += 0.01;
    ty += 0.01;
    
    // CHANGED: commented out wrapping behaviour
    //if (x < 0) {
    //  x += width;
    //}
    //else if (x >= width) {
    //  x -= width;
    //}
    //if (y < 0) {
    //  y += height;
    //}
    //else if (y >= height) {
    //  y -= height;
    //}
    
    bounce();
  }
  void bounce() {
    // Check the left and right
    if (x - size/2 <= 0 || x + size/2 >= width) {
      // Bounce on the x-axis
      vx = -vx;
    }

    // Check the top and bottom
    if (y - size/2 <= 0 || y + size/2 >= height) {
      // Bounce on the y-axis
      vy = -vy;
    }

    // Make sure the Parasite isn't off the edge
    x = constrain(x, 0+(size/2), width-(size/2));
    y = constrain(y, 0+(size/2), height-(size/2));
  }
  
  void attack(Cell host) {
    if (((x == host.x && y == host.y) || ((x <= host.x + (hitbox) && y <= host.y + (hitbox)) && ((x >= host.x - (hitbox) && y >= host.y - (hitbox)))))) {
      host.energy -= drainEnergy;
        constrain(host.energy,0,255);
        if (host.energy == 0) {
          host.energy--;
          killCount++;
          hitbox++;
          return;
        }
      }
    }
  

  void display() {
    fill(fill, 127); 
    stroke(255,0,192);
    ellipse(x, y, size+killCount, size+killCount);
  }
}