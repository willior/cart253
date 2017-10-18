// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  float SPEED = 5;
  float SIZE = 16;

  // The location of the ball
  float x;
  float y;

  // The velocity of the ball
  float vx;
  float vy;

  // The colour of the ball
  color ballColor = color(255,0,0);
  
  // Velocity modulator for hyper mode
  float vxMod;
  float vyMod;

  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties
  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    
    // randomyly determines starting trajectory for x-axis
    // added VERY SLIGHT randomness to the pong-off x-velocity: 1/10th of the velocity modulator
    vxMod = random(5,10);
    vyMod = random(5,10);
    
    if (random(-1,1) <= 0){
      vx = (-SPEED)-(vxMod/10);
    }
    else{
      vx = (SPEED)+(vxMod/10);
    }
    
    // randomly determines starting trajectory for y-axis
    // added slight randomness to the pong-off y-velocity: 1/5th of the velocity modulator
    if (random(-1,1) <= 0){
      
      vy = (-SPEED)-(vyMod/5);
    }
    else{
      vy = (SPEED)+(vyMod/5);
    }
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    
    // the ball now resets not in the center of the screen but at the cusp of the "territorial boundary"
    x = (width/2)+(scorePos*32);
    y = height/2;
    
    // the balls intial x-trajectory is determined by whichever player scored
    if (vx < 0) {
      vx = -SPEED;
    }
    else{
      vx = SPEED;
    }    
    
    // randomly determines whether the ball will begin moving up or down on y-axis
    if (random(-1,1) <= 0){ 
      vy = -SPEED;
    }
    else{
      vy = SPEED;
    }
  }
  
  // booleans to determine which player scores
  boolean goal1() {
    return (x + SIZE/2 < 0);
  }
  
  boolean goal2(){
    return ( x - SIZE/2 > width);
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      
      // random functions to change up ball velocity on bounce
      vxMod = random(5,10);
      vyMod = random(5,10);
      
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
        
        // checks to see if hyper mode is not active for player 1
        if (hyper1.hyperMode == 0){
          
          // randomness added to regular bounces; the degree of randomness is 1/5th that of a hyper bounce
          // (actually subtracted because this is for when the ball is moving left)
          vx -= (vxMod/5);
          
          // adds vyMod to vy if already positive
          if (vy >= 0){
            vy += (vyMod/5);
          }
          
          // otherwise subtracts vyMod from vy if negative
          else{
            vy -= (vyMod/5);
          }
          
          // adds 1 to player 1's hyper stock on bounce only when hyper mode inactive
          hyper1.stock++;
        }
        
        // if hyper mode is active, applies the full force of the randomly generated velocity modulators
        if (hyper1.hyperMode == 1){
          vx -= vxMod;
          
          // adds vyMod to vy if already positive
          if (vy >= 0){
            vy += vyMod;
          }
          
          // subtracts vyMod from vy if negative
          else{
            vy -= vyMod;
          }
          
          // resets hyper mode to 0
          hyper1.hyperMode = 0;
        }
          
      // moving right
      } else if (vx > 0) {
        
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
        
        // checks if hyper mode is not active for player 2
        if (hyper2.hyperMode == 0){
          
          // randomness added to regular bounces; the degree of randomness is 1/5th that of a hyper bounce
          vx += (vxMod/5);
          
          // only adds to vy if vy already positive
          if (vy >= 0){
            vy += (vyMod/5);
          }
          
          // otherwise subtracts if negative
          else{
            vy -= (vxMod/5);
          }
          
          // adds 1 to player 2's hyper stock on bounce only when hyper mode inactive
          hyper2.stock++;
        }
        
        // if hyper mode is active, applies the full force of the randomly generated velocity modulators
        if (hyper2.hyperMode == 1){
          vx += vxMod;
          vy += vyMod;
          hyper2.hyperMode = 0;
        }
      }
      // And make it bounce
      vx = -vx;
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(ballColor);
    rectMode(CENTER);

    // Draw the ball
    rect(x, y, SIZE, SIZE);
  }
}