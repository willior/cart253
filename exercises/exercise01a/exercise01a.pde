<<<<<<< HEAD
int CIRCLE_SPEED = 5; // creates the variable from which the circle's speed is initialized
color NO_CLICK_FILL_COLOR = color(0, 0, 0, 64); // creates a variable for the circles' colour
color CLICK_FILL_COLOR = color(64, 0, 0); // creates a variable for the circles' colour
color BACKGROUND_COLOR = color(0, 0, 0); // sets the variable for the background colour
color STROKE_COLOR = color(250, 250, 250); // sets the variable for the lines' colour
=======
final int CIRCLE_SPEED = 7; // creates the constant from which the circle's speed is initialized (7 pixels/frame?)
final color NO_CLICK_FILL_COLOR = color(250, 100, 100); // creates a constant for the circles' colour (pale red)
final color CLICK_FILL_COLOR = color(100, 100, 250); // creates a constant for the circles' colour (pale blue)
final color BACKGROUND_COLOR = color(250, 150, 150); // sets the constant for the background colour (an even paler red)
final color STROKE_COLOR = color(250, 150, 150); // sets the constant for the lines' colour (same pale red as background)
>>>>>>> f5030dd2134c8602a5543c6b9c90bcd073d7c91b
int CIRCLE_SIZE = 50; // sets a variable from which the circles' size is initialized

int circleX; // creates the variable circleX, which will be used as its position on the X axis
int circleY; // creates the variable circleY, which will be used as its position on the Y axis
int circleVX; // creates the variable circleVX, which will be used as its velocity along the X axis
int circleVY; // creates the variable circleVY, which will be used as its velocity along the Y axis
<<<<<<< HEAD
int CIRCLE_SIZEmodulator = 3; // creates a number from which CIRCLE_SIZE can be modulated
                              // *** change this from anything from 1 - 50 to create unique & interesting visuals
int CIRCLE_SIZEmax = 100; // sets maximum size in pixels for the circle
int CIRCLE_SIZEmin = 5; // sets minimum size in pixels for the circle
=======
int CIRCLE_SIZEmodulator = 1; // creates a number from which CIRCLE_SIZE can be modulated
int CIRCLE_SIZEmax = 100; // sets maximum size in pixels for the circle
int CIRCLE_SIZEmin = 5; // sets minimum size in pixels for the circle

>>>>>>> f5030dd2134c8602a5543c6b9c90bcd073d7c91b

void setup() { // setup function; initializes settings for our program
  size(640, 480); // sets the size (X, Y) of the window in pixels
  circleX = width/2; // sets the value for the variable circleX
  circleY = height/2; // sets the value for the variable circleY
  circleVX = CIRCLE_SPEED; // sets the value for the variable circleVX, which had been initialized as 7 in the constant CIRCLE_SPEED
  circleVY = CIRCLE_SPEED; // sets the value for the variable circleVY ...
  stroke(STROKE_COLOR); // fetches the colour of the circles' lines from the initialized constant STROKE_COLOR
  fill(NO_CLICK_FILL_COLOR); // fetches the colour of the circles' fill colour from the initialized constant NO_CLICK_FILL_COLOR
  background(BACKGROUND_COLOR); // fetches the colour of the background from the initialized constant BACKGROUND_COLOR
}

void draw() { // initializes our draw loop

<<<<<<< HEAD
if (mousePressed == true){                      // conditional for when mouse is pressed
  CIRCLE_SIZE = 50;                             // resets the size of the circle
  circleVX = 3;                                 // resets the speed of the circle
  circleVY = 3;                                 
  circleX = mouseX;                             // resets the position of the circle to where the cursor is
  circleY = mouseY;
}

=======
if (CIRCLE_SIZE == CIRCLE_SIZEmax){             // checks to see if CIRCLE_SIZE has reached the maximum value
  CIRCLE_SIZEmodulator = -CIRCLE_SIZEmodulator; // inverts CIRCLE_SIZEmodulator, making it negative
}

if (CIRCLE_SIZE == CIRCLE_SIZEmin ){            // checks to see if CIRCLE_SIZE has reached the minimum value
  CIRCLE_SIZE++;                                // increases the value of CIRCLE_SIZE by 1
  CIRCLE_SIZEmodulator = -CIRCLE_SIZEmodulator; // inverts CIRCLE_SIZEmodulator, making it positive
}

CIRCLE_SIZE += CIRCLE_SIZEmodulator;            // applies the value of CIRCLE_SIZEmodulator to CIRCLE_SIZE



>>>>>>> f5030dd2134c8602a5543c6b9c90bcd073d7c91b
if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
      
      // if statement that calculates the distance between the moving circle and the mouse cursor...
      // ... to determine whether the cursor is within the area occupied by a circle in the current draw loop
      
    fill(CLICK_FILL_COLOR); // if it is, fetches the fill colour of the circle from constant CLICK_FILL_COLOR (pale blue)
  }

  else {
    fill(NO_CLICK_FILL_COLOR); // if it is not, fetches the fill colour of the circle from constant NO_CLICK_FILL_COLOR (pale red)
  }
  
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE); // draws the circle
                                                       // its position (X,Y coordinates) set by the variables circleX and circleY 
                                                       // its size in pixels (width, height) by the variable CIRCLE_SIZE
                                                       
  circleX += circleVX; // adds the value of the variable circleVX to the variable circleX, effectively changing its position on the X axis
  circleY += circleVY; // adds the value of the variable circleVY to the variable circleY, effectively changing its position on the Y axis
  
  if (circleX + CIRCLE_SIZE/2 >= width || circleX - CIRCLE_SIZE/2 <= 0) {
    
   // if the position of the circle on the X axis PLUS its size divided by 2 is GREATER than the width of the window
   // OR
   // if the position of the circle on the X axis MINUS its size divided by 2 is LESS than 0
   
    circleVX = -circleVX; // then the integer variable circleVX becomes negative
  }
  if (circleY + CIRCLE_SIZE/2 >= height || circleY - CIRCLE_SIZE/2 <= 0) {
    
   // if the position of the circle on the Y axis PLUS its size divided by 2 is GREATER than the height of the window
   // OR
   // if the position of the circle on the Y axis MINUS its size dividded by 2 is LESS than 0
    
    circleVY = -circleVY; // then the integer variable circleVY becomes negative
    
  } // the circle's "velocity", determined by the variables circleVX and circleVY for both X and Y axes...
    // ... becomes negative when the circle appears to have "collided" with the edges of the window...
    // ... which, in practice, shifts its X velocity from positive to negative when hitting either side (and vice versa)...
    // ... and shifts its Y velocity from positive to negative when colliding either the top or bottom (and vice versa)...
    // ... effectively preventing the drawn circles to appear as "overlapping" the edges of the window...
    // ... and giving the effect of "bouncing" within the window's boundaries.

if (CIRCLE_SIZE >= CIRCLE_SIZEmax){             // checks to see if CIRCLE_SIZE has reached or exceeded the maximum value
  CIRCLE_SIZEmodulator = -CIRCLE_SIZEmodulator; // inverts CIRCLE_SIZEmodulator, making it negative
}

if (CIRCLE_SIZE <= CIRCLE_SIZEmin ){            // checks to see if CIRCLE_SIZE has reached exceeded the minimum value
  CIRCLE_SIZEmodulator = -CIRCLE_SIZEmodulator; // inverts CIRCLE_SIZEmodulator, making it positive
}

CIRCLE_SIZE += CIRCLE_SIZEmodulator;            // applies the value of CIRCLE_SIZEmodulator to CIRCLE_SIZE

if (mouseY > (height/2)){                       // sets a conditional where if the cursor is the lower half of the window...
  circleVY += mouseY / (height/2);              // ... the behaviour of the circle makes it appear to "bounce" on the bottom boundary
}
}

void mousePressed() { // sets the function for when the mouse is pressed
  background(BACKGROUND_COLOR); // reprints the background (paler red)
}