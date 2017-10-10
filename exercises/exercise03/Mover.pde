 class Mover {
 
 int x;
 int y;
 float vx;
 float vy;
 int size;
 int sizeMax;
 int sizeMin;
 int sizeMod;
 color fillColor;
 color defaultColor;
 color hoverColor;
 float randomBounce;
 
Mover(int tempX, int tempY, int tempVX, int tempVY, int tempSize, int tempSizeMax, int tempSizeMin, int tempSizeMod, color tempDefaultColor, color tempHoverColor) {
 
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
 
 void click(){
   if (size > sizeMin){
     sizeMod = -sizeMod;
   }
   
   if (size > sizeMax){
     size = (size+sizeMod);
   }
   else{
     sizeMod = -sizeMod;
     size = (size+sizeMod);
   }
 }
 
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
 }
 
 void handleBounce() {
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
   
   
void draw() {
  rectMode(CENTER);
   stroke(127);
   fill(0,0,0,127);
   rect(x,y,size,size);
 }
 }