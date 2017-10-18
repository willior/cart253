// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  float SPEED = 4;
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
    
    // random seeds for the x&y-axis velocity modulators
    vxMod = random(5,10);
    vyMod = random(-5,10);
    
    // randomyly determines starting trajectory for x-axis (ie. left or right)
    // then added VERY SLIGHT randomness to the pong-off x-velocity: 1/10th of the velocity modulator
    if (random(-1,1) <= 0){
      vx = (-SPEED)-(vxMod/10);
    }
    else{
      vx = (SPEED)+(vxMod/10);
    }
    
    // randomly determines starting trajectory for y-axis (ie. up or down)
    // then added slight randomness to the pong-off y-velocity: half of the velocity modulator
    if (random(-1,1) <= 0){
      
      vy = (-SPEED)-(vyMod/2);
    }
    else{
      vy = (SPEED)+(vyMod/2);
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
    // and of course slight randomness is added through 1/10th of vxMod
    if (vx < 0) {
      vx = (-SPEED)-(vxMod/10);
    }
    else{
      vx = (SPEED)+(vxMod/10);
    }    
    
    // randomly determines whether the ball will begin moving up or down on y-axis
    // with added randomness to determine velocity
    if (random(-1,1) <= 0){ 
      vy = (-SPEED)-(vyMod/2);
    }
    else{
      vy = (SPEED)+(vyMod/2);
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
      // vxMod will always make the ball faster on the x-axis
      vxMod = random(0,10);
      // vyMod has the chance of making the ball move slower on the y-axis
      // in some cases (ie. hyper smashes), it can even invert the y-trajectory!
      vyMod = random(-7.5,7.5);
      
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
        
        // checks to see if hyper mode is not active for player 1
        if (hyper1.hyperMode == 0){
          
          // randomness added to regular bounces; the degree of randomness is 1/10th that of a hyper bounce
          // (actually subtracted because this is for when the ball is moving left)
          vx -= (vxMod/10);
          
          // got rid of the logic to determine whether to add or subtract to vy...
          // and instead incorporated it into the random() function instead.
          // makes it more random this way, as the values can now be added or subtracted regardless of...
          // whether the ball is currently moving up or down...
          // so sometimes you'll get a straight shooting fast one OR a sharp angled one
          vy += (vyMod/10);
         
          // adds 1 to player 1's hyper stock on bounce only when hyper mode inactive
          hyper1.stock++;
        }
        
        // if hyper mode is active, applies the full force of the randomly generated velocity modulators
        if (hyper1.hyperMode == 1){
          vx -= vxMod;
          vy += vyMod;
          
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
          vy += (vyMod/5);
          
          
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