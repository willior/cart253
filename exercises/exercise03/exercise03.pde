// generates 2 "snakes" of infinite length drawn out of coloured transparent circles that bounce around within a window
// type (class): Bouncer (capital letter)
// variable: bouncer (lowercase letter)
// functions of objects are called methods
// creates backgroundColor from a color value
// CHANGED: background colour to black
color backgroundColor = color(0);

Bouncer bouncer;
Bouncer bouncer2;

// sets up the size of the window and background colour
// creates the "new" objects bouncer and bouncer2 from the class Bouncer
// sets their properties (which are defined in the class Bouncer) which are:
// width/2: starting position on X axis
// height/2: starting position on Y axis
// 2 & -2: X velocity of the balls
// 2 & 2: Y velocity of the balls
// 50: size of the balls
// CHANGED: added property declarations for balls' max (100) and min (50) size
// added variable sizeMod, which will be used to check if the balls' size should increase or decrease
// color(150,0,0,50) & color(0,0,150,50): sets colour/transparency of the balls
// color(255,0,0,50) & color(0,0,255,50): sets colour of the balls when the cursor is hovering over a drawn ball
void setup() {
  size(640,480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2,height/2,2,2,50,100,11,10,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,100,11,10,color(0,0,150,50),color(0,0,255,50));
}

// objects' functions, such as update, are called methods
// draw loop that runs bouncer and bouncer2's methods
void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
//  click();
}

// runs the click() method for both bouncer objects when the mouse is clicked
void mouseClicked(){
  bouncer.click();
  bouncer2.click();
}