//Choose one or more of the "tricks" we looked at (such as noise(),
// trigonometry functions, ArrayList, timers, or window resizing).
// Use your trick(s) to create a simple interactive experience that you think
// is an interesting use of that 'trick'.

// So you might take the "resizing" and "timer" ideas and make a little game
// where it asks you to resize the window to a specific size within a time limit.
// Or perhaps something similar where it gives dimensions and you have to resize
// the window to your best guess at those dimensions and you get points for accuracy.
// Or perhaps a game where resizing the window is how you interact with it - 
// like a version of Pong where making the window smaller in the y-axis
// moves the paddle up and making it larger in the y-axis moves the paddle down
// (with the rest of the game scaling to account for it). Or maybe you use the "pets"
// from the noise() examples and create something like Griddies from last week except
// that they can roam freely around on the screen.

// sine wave code taken from slides 07-Math-tricks
float theta = 0;
int x = 0;

void setup() {
  size(600,600);
  background(0);
  fill(255);
}

void draw() {
  float y = height/2 + (sin(theta) * height/2);
  ellipse(x,y,10,10);
  x++;
  theta += 0.05;
}