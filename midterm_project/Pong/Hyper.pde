class Hyper {
  
  int hyperSize;
  int hyperX;
  int hyperY;
  int stock;
  int hyperMode;
  char hyperKey;
  
    // The fill color of the paddle
  color hyperFull = color(255,0,0);
  color hyperEmpty;
  color hyperStroke;
  
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
  
  void update() {
    constrain(stock,0,3);
  }
  
  void display() {
    // Set display properties
    stroke(hyperStroke);
    fill(hyperEmpty);
    rectMode(CENTER);
    constrain(stock,0,3);             // why doesn't this work??
    
    // quick & dirty way to keep stock from exceeding 3 as i couldn't get constrain to work:
    if(stock > 3){
      stock = 3;
    }
    if(stock == 3){
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
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
      if (key == hyperKey) {
        hyperMode = 1;
        stock--;
        constrain(stock,0,3);        // again, doesn't work
        
// quick and dirty way to get stock from going under 0:
        if (stock < 0){
          stock = 0;
        }
      }
      else{
        hyperMode = 0;
      }
    }
    void keyReleased() {
      hyperMode = 0;
    }
}