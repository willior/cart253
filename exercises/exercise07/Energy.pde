// Energy
//
// A class that defines a bar to display the player's huddle Energy
class Energy {
  
  // declaration of variables to be used by the Energy class
  int energySizeX;
  int energySizeY;
  int energyX;
  int energyY;
  int eLevel;
  int energyMode;
  char energyKey;
  
  // the colour of a full energy eLevel (green)
  color energyFull = color(64,255,0);
  
  // colour properties for the Energy class
  color energyEmpty;
  color energyStroke;
  
  // Energy constructor for energy bar
  Energy(int _energySizeX, int _energySizeY, int _energyX, int _energyY, int _eLevel, int _energyMode, color _energyEmpty, color _energyStroke){
    
    energySizeX = _energySizeX;
    energySizeY = _energySizeY;
    energyX = _energyX;
    energyY = _energyY;
    eLevel = _eLevel;
    energyMode = _energyMode;
    energyEmpty = _energyEmpty;
    energyStroke = _energyStroke;
    
  }
  
  // setting properties for the display of the energy eLevels
  void display() {
    stroke(energyStroke);
    fill(energyEmpty);
    rectMode(CORNER);
    
    if(eLevel > 100){
      eLevel = 100;
    }
    
    // formatting the display of the energy eLevels
    
    fill(energyEmpty);
    rect(energyX, energyY, energySizeX, energySizeY);
    
    
    
    if(eLevel == 100){
      fill(energyFull);
      rect(energyX, energyY, energySizeX, energySizeY);
      

    }
  }
}