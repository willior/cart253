// initializes/declares the class (or type) Bouncer, allowing it to be used as an object
// and the variables x, y, vx, vy, size and the colours fillColor, defaultColor, and hoverColor
class Bouncer {
  
 int x;
 int y;
 //CHANGED: vx and vy to floats in order to be modulated via a random() function
 float vx;
 float vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
 //added variable randomBounce which will be the factor from which vx and vx are changed
 float randomBounce;
 
 // declares the properties of the class Bouncer by fetching the values entered when the new objects are created (in exercise03)
 // and putting them in temp... variables, from which the variables declared above (x,y,vx,vy etc.) are given values
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 // function (or method) that "updates" the ball by adding the vx value to the x value and the same for the y values
 // also runs the handleBounce() and handleMouse() methods
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
   handleMouse();
 }
 
 // method that "handles" the "bounce"; inverts vx or vy when the boundary of the circle hits the respective edge of the window
 // CONSTRAINS the values of x & y (ie. the ball's current position) to a MINIMUM of half its size
 // and a MAXIMUM of the window's length/height minus half its size
 void handleBounce() {
   
   // CHANGED: added a random function to apply a degree of randomness to vx and vy when the ball "bounces"
   randomBounce=random(2);
   
   if (x - size/2 < 0 || x + size/2 > width) {
     
    // adds randomBounce to vx
    vx += randomBounce;
    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     // adds randomBounce to vy
     vy += randomBounce;
     vy = -vy;
   }

   
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 // method that "handles" the behaviour of the mouse
 // dist calculates the distance between 2 points
 // if statement that checks if the distance of the cursor's position is less than half the circle's size
 // if so (aka the mouse is hovering over the circle(s) being drawn), the circle's fill colour is fetched from hoverColor
 // else, the defaultColor is fetched
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 
 // draws the circle after fetching its attributes:
 // noStroke disables the outline
 // fill sets the fillColor (fetched form either hoverColor or defaultColor as described above)
 // ellipse draws the circle (x-pos, y-pos, x-size, y-size)
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}