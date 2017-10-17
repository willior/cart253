class Hyper {
  
  int hyperA;
  int hyperB;
  int hyperC;
  int hyperSize;
  int hyperX;
  int hyperY;
  int stock;
  int hyperMode;
  char hyperKey;
  
  color hyperColor = color(255,0,0);
  
  Hyper(int _hyperSize, int _hyperX, int _hyperY, int _stock, int _hyperMode, char _hyperKey){
    

    hyperSize = _hyperSize;
    hyperX = _hyperX;
    hyperY = _hyperY;
    stock = _stock;
    hyperMode = _hyperMode;
    hyperKey = _hyperKey;    
  }
  
  void update() {
    
    }
    
      
    }
  
  void display() {
    // Set display properties
    noStroke();
    fill(255);
    rectMode(CENTER);
    
    rect(hyperX, hyperY, hyperSize, hyperSize);
    
    if (stock > 0){
      fill(hyperColor);
      
      
    }
  }
  
    // checks to see if hyperKey is pressed  
    void keyPressed() {
      if (key == hyperKey && stock > 0) {
        hyperMode = 1;
      }
      else{
        hyperMode = 0;
      }
    }
    void keyReleased() {
      hyperMode = 0;
    }
  