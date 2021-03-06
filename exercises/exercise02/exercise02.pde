// initializes all the colours and integer variables that will be used in the program
color backgroundColor = color(0,0,0,127);
int backgroundColorMod = 5;

int numStatic = 1000;          
int staticSizeMin = 1;
int staticSizeMax = 3;
int staticWhite = 125;
color staticColor = color(staticWhite);
int staticMod = 10;

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 17;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
int maxVX = 20;
int maxVY = 20;
int ballSpeed = 5;
int ballSize = 16;
float ballSpeedModX;
float ballSpeedModY;
color ballColor = color(255);
color ballColorDanger = color(255,0,0);
int score = 0;
int scoreMod;
int highScore;
int counter = 1;

// setup function to initialize the window size and paddle/ball function behaviours
void setup() {
  size(640, 480);
  
  setupPaddle();
  setupBall();
}

// sets up the position of the paddle at startup
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

// sets up the position/speed of the ball at startup
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
  ballSpeedModX = 0;
  ballSpeedModY = 0;
  scoreMod = 0;
}

// initializes the draw loop: draws background, noise, paddle and ball
// UPDATES the positions of the Paddle and Ball (by way of the update functions) before drawing them
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

// function that draws the visual noise effect using a variety of random functions
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticWhite);
   rect(x,y,staticSize,staticSize);
  }
}

// function that determines paddle behaviour
// paddleX: position | paddleVX: velocity
// constrain: function that constrains a defined value to a range of 2 other declared values...
// ... to prevent the paddle from moving off the edge of the screen
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

// function that determines ball behaviour
// includes functions for whether the ball hits the paddle, the boundaries, or the bottom
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// function that draws the paddle
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// function that draws the ball
void drawBall() {
  
  // added feature where the ball turns a bright red when in the lower most quartile
    if (ballY >= (height * 0.75)){
      rectMode(CENTER);
      noStroke();
      fill(ballColorDanger);
      rect(ballX, ballY, ballSize, ballSize);
    }
    else{
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
    }
}

//CHANGED:
// function that determines the behaviour of the ball when it hits the paddle
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {

    ballY = paddleY - paddleHeight/2 - ballSize/2;
    
    // ball speed modulation on successful deflection
    // CHANGED: added randomness factors to both X and Y axes
    // the ball has a chance to diminish in speed, however most of the time it will increase
    float ballSpeedRandX = random (-2, 2);
       ballSpeedModX = (ballSpeedRandX + 1);
    float ballSpeedRandY = random (-2, 2);
       ballSpeedModY = (ballSpeedRandY + 1);
    ballVY += ballSpeedModY;
    if (ballVX > 0 ){
      ballVX += ballSpeedModX;
    }
    else{
      ballVX -= ballSpeedModX;
    }

    ballVY = -ballVY;
    
    // added scoring system:
    // the faster the ball gets, the more points the player receives for successfully deflections
    // prints current score on successful deflection
    // made the score into a factor of 1000 because bigger numbers = more fun
    scoreMod = (counter * 1000);
    score += scoreMod;
    println (score);
    
    // static modulation
    if (staticWhite <= 245){
    staticWhite += staticMod;
    numStatic += 1000;
    }
    
    //prevents staticWhite from exceeding 255
    else {
      numStatic += 1000;
    }
    counter++;
  }
}

// function that determines whether the ball has collided with the paddle (true) or not (false)
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

// function that resets the position of the ball to the center of the window when it hits the bottom (failure)
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
    
    // CHANGED:
    // resets the ball speed to default
    ballSpeedModX = 0;
    ballSpeedModY = 0;
    ballVX = ballSpeed;
    ballVY = ballSpeed;
    
    // sets high score
    if (score >= highScore){
      highScore = score;
    }
    
    // prints current high score when loss, resets score and scoreMod
    println(highScore);
    score = 0;
    scoreMod = 0;
    
    //resets static;
    staticWhite = 125;
    numStatic = 1000;
    
    //resets counter;
    counter = 0;
  }
}

// 
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

// function that declares the behaviour of how the ball bounces off the boundaries
// inverts VX or VY values when colliding with boundaries
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}
  

// function initializing controls, ie. when the left or right arrows are pressed
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

// resets the paddle speed (paddleVX) to 0 when an arrow key is released
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}