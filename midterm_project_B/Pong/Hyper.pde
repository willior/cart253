class Hyper {
  
  int hyperSize;
  int hyperX;
  int hyperY;
  int stock;
  int hyperMode;
  char hyperKey;
  
    // The fill color of the paddle
  color paddleColor = color(255);
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
    ball.collide(leftPaddle);{
      hyper1.stock++;
    }
    ball.collide(rightPaddle);{
      hyper2.stock++;
    }
    constrain(stock,0,3);
  }
  
  void hyperDisplay() {
    // Set display properties
    noStroke();
    fill(255);
    rectMode(CENTER);
    if(stock == 3){
      fill(hyperColor);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    else if(stock == 2){
      fill(hyperColor);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      fill(paddleColor);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    else if(stock == 1){
      fill(hyperColor);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      fill(paddleColor);
      rect((hyperX+20), hyperY, hyperSize, hyperSize);
      rect((hyperX+40), hyperY, hyperSize, hyperSize);
    }
    
    else {
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
        constrain(stock,0,3);
      }
      else{
        hyperMode = 0;
        paddleColor = (255);
      }
    }
    void keyReleased() {
      hyperMode = 0;
      paddleColor = (255);
    }
}