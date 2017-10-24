// Parasite
//
// A class defining the behaviour of a single Parasite
// which can move randomly in the window (within the grid),
// and drains energy from Griddies

class Parasite {
  // Sets the level of energy a parasite will drain from a griddie by collision
  int drainEnergy = 50;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(127,0,255);

  // Parasite(tempX, tempY, tempSize)
  //
  // Set up the Parasite with the specified location and size
  Parasite(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }
  
  // update()
  //
  // Move the Parasite
  void update() {
    
    if (energy == 0) {
      return;
    }
    
    int xMoveType = floor(random(-1,2));
    int yMoveType = floor(random(-1,2));
    x += size * xMoveType;
    y += size * yMoveType;
    
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
  
}