// Cell
//
// a class that defines cell objects, which float around and can be influenced with mouse movement
// they slowly lose energy over time and gain a small amount of energy when colliding with other cells
// once killed, they can be resurrected by antibodies

class Cell {
  
  int maxEnergy = 255;
  float moveEnergy = -.1;
  int collideEnergy = 10;
  int size;
  int energy;
  
  float tx = random(0,100);
  float ty = random(0,100);
  
  float speed = 10;
  float x;
  float y;
  
  // CHANGED: moved velocity variables to top so that we may use a bounce function
  // variables for x & y velocity
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
    
    // terminates the function if energy is less than 0
    if (energy <= 0) {
      strokeWeight(1);
      stroke(255,0,0);
      line(x,y,x+20,y+20);
      line(x,y+20,x+20,y);
      return;
    }
    
    if (energy == 0) {
      energy--;

      
      return;
    }
    
    // behaviour for cells with energy remaining
    else if (energy > 0) {
    
    // behaviour for how mouse movement affects velocities
    // aka "wind direction"
    // as it is now, there are only 4 wind directions, NE, NW, SE, SW
    // depending on which quadrant the cursor is in at the time
    // well add more variance/possibilities for final project
    
    vx = speed * (noise(tx) * 2 - 1) + ((mouseX) - (width/2)) / (width/10);
    vy = speed * (noise(ty) * 2 - 1) + ((mouseY) - (height/2)) / (height/10);
    
    // behaviour for how brightestPixel affects velocities    
    // orients Cell velocity towards brightestPixel
    // modifier = 2, which is twice the strength as the mouse position modifier
    // emphasizing using the light source to herd the cells together
    // allowing them to survive easier
    if (brightestPixel.x > x){
      vx += 2;
    }
    if (brightestPixel.x < x){
      vx -= 2;
    }
    if (brightestPixel.y > y){
      vy += 2;
    }
    if (brightestPixel.y < y){
      vy -= 2;
    }
    
    // modifies velocities based on cursor position
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
  
  
    // CHANGED: commented out wrap detection in order to test with bouncing cells
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
    
    bounce();
    
    // energy 
    energy += moveEnergy;
    energy = constrain(energy,0,maxEnergy);
    energyOffset = maxEnergy-energy;
    }
  }
  
  // handles bouncing off window edges
  // code taken from handleBounce() function in exercise06 Bouncer template
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

    // Make sure the Bouncer isn't off the edge
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
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
    fill((energyOffset), 255-energyOffset, 0, energy);
    noStroke();
    ellipse(x,y,20,20);
  }
}