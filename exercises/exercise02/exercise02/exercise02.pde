// initializes all the colours and integer variables that will be used in the program
color backgroundColor = color(64,0,0,1);

int numStatic = 1000;          
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(128);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
int ballSpeedMod;
color ballColor = color(255);
int score = 0;
int scoreMod = 0;
int highScore;

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
  ballSpeedMod = 0;
}

// initializes the draw loop: draws background, noise
// UPDATES the positions of the Paddle and Ball (by way of the update functions), then draws them
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
  println (score);
}

// function that draws the visual noise effect using a variety of random functions
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
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
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

//CHANGED:
// function that determines the behaviour of the ball when it hits the paddle
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    
    // added code to increase the ball speed modulator each time the ball is successfully deflected
    ballSpeedMod++;
    ballVY += ballSpeedMod;
    ballVX += ballSpeedMod;
    ballVY = -ballVY;
    if (ballSpeedMod >= 3){
      score++;
    } 
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


// function that resets the position of the ball to the center of the window when it hits the bottom
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
    
    // CHANGED:
    // resets the ball speed to default
    ballSpeedMod = 0;
    ballVX = ballSpeed;
    ballVY = ballSpeed;
  }
}

// 
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

// function that declares the behaviour of how the ball bounces off the boundaries
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