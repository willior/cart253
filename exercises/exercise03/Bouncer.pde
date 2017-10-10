// initializes/declares the class (or type) Bouncer, allowing it to be used as an object
// and the variables x, y, vx, vy, size and the colours fillColor, defaultColor, and hoverColor
class Bouncer {
  
 int x;
 int y;
 // CHANGED: vx and vy to floats in order to be modulated via a random() function
 float vx;
 float vy;
 int size;
 // CHANGED: added variables for maximum and minimum sizes of the circles
 int sizeMax;
 int sizeMin;
 int sizeMod;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
 //added variable randomBounce which will be the factor from which vx and vx are changed
 float randomBounce;
 
 // declares the properties of the class Bouncer by fetching the values entered when the new objects are created (in exercise03)
 // and putting them in temp... variables, from which the variables declared above (x,y,vx,vy etc.) are given values
 // CHANGED: added properties for sizeMax, sizeMin and sizeMod
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, int tempSizeMax, int tempSizeMin, int tempSizeMod, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   sizeMax = tempSizeMax;
   sizeMin = tempSizeMin;
   sizeMod = tempSizeMod;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 // CHANGED: added method that modifies the size of the balls by the variable sizeMod each each time it is run (ie. by mouse clicked)
 // sizeMod is used to either add or subtract a value (10) from size depending on whether sizeMin or sizeMax has been reached/exceeded
 // first checks to see if the size is less than sizeMin; inverts sizeMod if it is
 // second checks to see if size is less than sizeMax; adds sizeMod to size if true
 // else it inverts sizeMod, then adds sizeMod to size
 void click(){
   if (size < sizeMin){
     sizeMod = -sizeMod;
   }
   
   if (size < sizeMax){
     size = (size+sizeMod);
   }
   else{
     sizeMod = -sizeMod;
     size = (size+sizeMod);
   }
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
   randomBounce=random(1);
   
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
 // stroke(255) gives each circle a white outline
 // fill sets the fillColor (fetched form either hoverColor or defaultColor as described above)
 // ellipse draws the circle (x-pos, y-pos, x-size, y-size)
 // CHANGED: stroke colour to create something more visually appealing
 void draw() {
   stroke(255);
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}