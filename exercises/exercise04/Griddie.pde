// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255,0,0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {
    
    // QUESTION: What is this if-statement for?
    // return in this case is used to break out of the update() function
    // the if-statement checks if a Griddie's energy level is at 0
    // if it is, the function is terminated before the remaining steps can occur...
    // effectively "killing" that specific griddie. forever.
    if (energy == 0) {
      return;
    }
    
    // QUESTION: How does the Griddie movement updating work?
    // x & yMoveType: integer values randomly chosen between -1, 0, 1, & 2
    // x & y += size * x&yMovetype: adds griddies' size, 20px...
    // by a factor of the previously chosen random integer...
    // to the x & y int values, ie. their coordinates...
    // effectively allowing them to "move" in "blocks" of 20px...
    // effectively creating a "grid"-style organization, each cell being 20*20
    
    int xMoveType = floor(random(-1,2));
    int yMoveType = floor(random(-1,2));
    x += size * xMoveType;
    y += size * yMoveType;
    
    // QUESTION: What are these if statements doing?
    // the first checks if x is less than 0, ie. if it is off the left side of the window
    // if it is, it adds the width of the window to the x value coordinate...
    // effectively "wrapping" it around to the other side of the window...
    // as opposed to having it hidden or destroyed
    if (x < 0) {
      x += width;
    }
    
    // the second checks if x is greater than or equal to the width of the window, ie. if it is off the right side
    // if it is, it subtracts the width of the window from the x value coordinate...
    // effectively "wrapping" it around to the other side of the window
    else if (x >= width) {
      x -= width;
    }
    
    // the 3rd & 4th if statements do the same thing described above
    // only for the y coordinates
    if (y < 0) {
      y += height;
    }
    else if (y >= height) {
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;
    
    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy,0,maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level
  
  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    // this if statement checks if either of the colliding griddies' energy levels are equal to 0
    // if they are, return terminates the function, preventing the rest of it from occurring
    if (energy == 0 || other.energy == 0) {
      return;
    }
    
    // QUESTION: What does this if-statement check?
    // this if statement checks if the x&y values of a griddie...
    // are equal to the x&y calues of a colliding griddie...
    // ie. if they are the same, or overlapping
    // if they are, the griddie's energy is increased by 10...
    // then constrains the energy value to not fall below 0 or exceed 255
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy,0,maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    // the color fill is declared as red up above
    // this fill function sets the parameters for the rect being drawn...
    // the value for its alpha channel being taken from its energy value...
    // effectively displaying the griddies with varying degrees of transparancy...
    // depending on their energy levels
    // ie. less energy = more transparency
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}