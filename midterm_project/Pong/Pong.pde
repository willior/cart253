// current status:

// typical Pong game with the "score" built-in to the visuals
// no longer a "first-to-10" scoring system, but a "tug-of-war" kind of scoring system
// added the "hyper smash": for each successful deflection, the player accrus a "hyper stock"
// hyper stocks can be spent to significantly amplify the degree of randomness applied...
// ...  to the ball's velocities on the next successful bounce
// the player's paddle turns red to signify "hyper mode"
// the players' hyper stocks are shown in the bottom corners
// each player may hold a maximum of 3 hyper-stocks

// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles, ball, and hyper stocks
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;
Hyper hyper1;
Hyper hyper2;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// variable for tracking score
int scorePos;

// variables for players' hyper stocks
int stock1 = 0;
int stock2 = 0;
color hyperEmpty1 = color(0);
color hyperEmpty2 = color(255);
color hyperFull1 = color(255,0,0);
color hyperFull2 = color(255,0,0);
color hyperStroke1 = color(255);
color hyperStroke2 = color(0);

// The background colour during play (black)
color backgroundColor = color(0);

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  
  // the left paddle is now black so that it shows up on the white half of the screen
  // changed controls slightly
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q', (0));
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '-', 'p', (255));

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
  
  // added hyper class for hyper smashes
  // (int _hyperSize, int _hyperX, int _hyperY, int _stock, int _hyperMode, char _hyperKey)
  hyper1 = new Hyper(10, 50, (height - 50), stock1, 0, '`', hyperEmpty1, hyperStroke1);
  hyper2 = new Hyper(10, (width - 90), (height - 50), stock2, 0, '=', hyperEmpty2, hyperStroke2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  background(backgroundColor);
  
  // Used a white rect to act as the abstract score display
  fill(255);
  
  // The rect moves in accordance to scorePos, which goes up or down in value depending on who scores
  rect((scorePos*32),height/2,width,height);

  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

  // split 'off screen' function into 2 separate functions for each player
  // score is displayed based on a factor of scorePos, which itself is used as 1/10 of the width of the screen
  // the first person to reach 10 (aka cover the entire screen) wins
  
  // function for when player 1 scores
  if (ball.goal1()) {
    scorePos++;
    
    // checking to see if player 1's maximum score has been reached...
    if (scorePos < 10){
      ball.reset();
    }
    
    // ... if it has, they win
    else {
      println("P1 win");
      background(255);
    }
  }
  
  // function for when player 2 scores
  if (ball.goal2()) {
    scorePos--;
    
    // checking to see if player 2's maximum score has been reached...
    if (scorePos > -10){
      ball.reset();
    }
    // ... if it has, they win
    else {
      println("P2 win");
    }
  }
  
  // checks if player 1's hyper mode has been activated; if it has, changes paddle color to red
  if (hyper1.hyperMode == 1){
    leftPaddle.paddleColor = color(255,0,0);
  }
  
  // otherwise it is drawn as black
  else{
    leftPaddle.paddleColor = (0);
  }
  
  // checks if player 2's hyper mode has been activated; if it has, changed paddle color to red
  if (hyper2.hyperMode == 1){
    rightPaddle.paddleColor = color(255,0,0);
  }
  
  // otherwise it is drawn as white
    else{
      rightPaddle.paddleColor = (255);
    }

  // Display the paddles, ball, and hyper stocks
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  hyper1.display();
  hyper2.display();

}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods, as well as the new hyper modes'
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
  hyper1.keyPressed();
  hyper2.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}