// Hyper
//
// A class that defines a 3 small boxes per player to determine the amount of hyper stocks they currently have
// hyper stocks are used to "hyper smash" the ball, adding substantial values to its x & y velocities

class Hyper {
  
  // declaration of variables to be used by the Hyper class
  int hyperSize;
  int hyperX;
  int hyperY;
  int stock;
  int hyperMode;
  char hyperKey;
  
  // the colour of a full hyper stock (red)
  color hyperFull = color(255,0,0);
  
  // colour properties for the Hyper class
  color hyperEmpty;
  color hyperStroke;
  
  // HYPER CONSTRUCTOR also my new nickname
  Hyper(int _hyperSize, int _hyperX, int _hyperY, int _stock, int _hyperMode, char _hyperKey, color _hyperEmpty, color _hyperStroke){
    
    hyperSize = _hyperSize;
    hyperX = _hyperX;
    hyperY = _hyperY;
    stock = _stock;
    hyperMode = _hyperMode;
    hyperKey = _hyperKey;
    hyperEmpty = _hyperEmpty;
    hyperStroke = _hyperStroke;
    
  }
  
  // setting properties for the display of the hyper stocks
  void display() {
    stroke(hyperStroke);
    fill(hyperEmpty);
    rectMode(CENTER);
    
    // quick & dirty way to keep stock from exceeding 3 as i couldn't get constrain to work:
    // (actually learned i was just using it wrong)
    if(stock > 3){
      stock = 3;
    }
    
    // formatting the display of the hyper stocks
    // if 3, all 3 rects are red
    if(stock == 3){
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    // if 2, only 2 are, etc.
    else if(stock == 2){
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    else if(stock == 1){
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    
    else if(stock == 0) {
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
  }
  
    // checks to see if hyperKey is pressed  
    void keyPressed() {
      
      // activates hyper mode on hyperKey press
      if (key == hyperKey) {
        hyperMode = 1;
        
        // subtracts one hyper stock
        stock--;
        
        // quick and dirty way to prevent stock from going under 0:
        if (stock < 0){
          stock = 0;
        }
      }
    }
  }