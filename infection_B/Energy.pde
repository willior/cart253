// Energy
//
// A class that defines a bar to display the player's herding Energy

class Energy {

  // declaration of variables to be used by the Energy class
  int energySizeX;
  int energySizeY;
  int energyX;
  int energyY;
  float eLevel;
  int energyMode;
  char energyKey;

  // the colour of a full energy eLevel (green)
  color energyFull = color(64, 255, 0);

  // colour properties for the Energy class
  color energyEmpty;
  color energyStroke;

  // Energy constructor for energy bar
  Energy(int _energySizeX, int _energySizeY, int _energyX, int _energyY, int _eLevel, int _energyMode, color _energyEmpty, color _energyStroke) {

    energySizeX = _energySizeX;
    energySizeY = _energySizeY;
    energyX = _energyX;
    energyY = _energyY;
    eLevel = _eLevel;
    energyMode = _energyMode;
    energyEmpty = _energyEmpty;
    energyStroke = _energyStroke;
  }

  // update function for energy usage
  void update() {

    // goes through all the cells
    for (int i = 0; i < cells.length; i++) {

      // modify cell velocities based on their position in relation to mouse cursor on click
      // additional logic checks if there remains sufficient energy; velocities unaffected if true
      if ((mouseX > cells[i].x) && (bar.eLevel > 3)) {
        cells[i].vx += 4;
      }
      if ((mouseX < cells[i].x) && (bar.eLevel > 3)) {
        cells[i].vx -= 4;
      }
      if ((mouseY > cells[i].y) && (bar.eLevel > 3)) {
        cells[i].vy += 4;
      }
      if ((mouseY < cells[i].y) && (bar.eLevel > 3)) {
        cells[i].vy -= 4;
      }
    }
  }

  // setting properties for the display of the energy eLevels
  void display() {
    strokeWeight(1);
    stroke(energyStroke);
    fill(energyEmpty);
    rectMode(CORNER);

    // formatting the display of the energy eLevels
    fill(energyEmpty);
    rect(energyX, energyY, energySizeX, energySizeY);

    fill(energyFull);
    rect(energyX, energyY, eLevel, energySizeY);
  }
}
