// ideas: add a "hyper" mode that allows a hyper-smash once every 3 (?) deflections
// increases the ball's speed substantially, changes colour, as well as its point value if goal
// hyper-smashes can incorporate some kind of random property to affect game behaviour
  // for example, giving a curve to the ball and/or changing how it looks
// a hyper-smash can be counter-hyper-smashed; speed is retained, maybe changes color/increased point value
// counter-hyper-smashes may also change the game; perhaps by inverting the opposing player's controls temporarily
  // and/or adding visual interference/distraction, or lowering paddle speed and/or length
// if 3 successful counter-hyper-smashes are performed in a row, that player has the option to perform a hyper-break
  // which has the potential of literally breaking the other player's paddle
    // either ending the round immediately or afflicting the "broken" player in some crippling way

// scoring:
// -1 point for letting a ball through
// +1 point for hyper-smashing and getting a goal
// +1 point for hyper-break
// first to 10 points wins
// rather than display points as a number, will be represented somehow through colours/background

// sound effects?
  // typical beep boops for normal deflections
  // absurdly over-the-top sound effects for hyper-smashes

// visuals? (images? or just colour changes?)

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

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// variable for tracking score
int scorePos;

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
  leftPaddle = new Paddle(PADDLE_INSET, height/2, '1', 'q', (0));
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, '0', 'p', (255));

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
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

  // split 'off screen' function into 2 separate functions for both sides
  if (ball.goal1()) {
    scorePos++;
    if (scorePos < 10){
      ball.reset();
    }
    else {
      println("P1 win");
      background(255);
    }
  }
  if (ball.goal2()) {
    scorePos--;
    if (scorePos > -10){
      ball.reset();
    }
    else {
      println("P2 win");
    }
  }

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}