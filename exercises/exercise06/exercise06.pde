import processing.video.*;

// exercise 06
//
// a game where parasites (blue) drain energy from your cells (red)
// release antibodies (yellow) by clicking on the screen to heal/revive your cells
// you are given 3 antibodies to start with, and receive an additional one every 3 seconds
// noise() function regulates objects' movement
// however, cell/antibody movement can be influenced with mouse movement
// used a timer to track "score"; the timer resets when the game is reset by pressing 'R'
// CHANGED: 
// 

// video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector brightestPixel = new PVector(-1,-1);

// sound library
 import processing.sound.*;
 SoundFile pop;
 SoundFile bgm;

// initializing arrays
Cell[] cells = new Cell[200];
Parasite[] parasites = new Parasite[10];
Antibody[] antibodies = new Antibody[10];

// creating the meter to display antibody stock
Hyper meter;
color hyperEmpty = color(255);
color hyperStroke = color(0);

// variables for time and score
int time = 0;
int score = 0;

void setup() {
  
  size(800,450);
  pop = new SoundFile(this,"pop.wav");
  bgm = new SoundFile(this,"bgm.mp3");
  
  // plays the background music in a loop
  bgm.loop();
  
  // Start up the webcam
  video = new Capture(this, 800, 450, 30);
  video.start();
  
  // player starts with 3 antibodies
  int stock = 3;
  meter = new Hyper(10, 50, (height - 50), stock, 0, hyperEmpty, hyperStroke); 
  
  // instantiating cells
  for (int i = 0; i < cells.length; i++) {

    int x = floor(random(0, width));
    int y = floor(random(0, height));
    
    cells[i] = new Cell (x, y, 20);
  }
  
  // and parasites
  for (int p = 0; p < parasites.length; p++) {
    int x = floor(random(0, width));
    int y = floor(random(0, height));
    parasites[p] = new Parasite(x, y, 20);
    antibodies[p] = new Antibody (x, y, 20);
  }
}

void draw() {

  // A function that processes the current frame of video
  handleVideoInput();
  
  // Draw the video frame to the screen
  image(video, 0, 0);
  
  // Draw a rect that acts as a transparent overlay for the video, providing cleaner visuals
  fill(64,64,64,128);
  noStroke();
  rectMode(CORNERS);
  rect(0,0,width,height);
  
  // For now we just draw a crappy ellipse at the brightest pixel
  fill(0,255,255);
  stroke(255,127,0);
  ellipse(brightestPixel.x,brightestPixel.y,50,50);
  
  // variable to store the amount of dead cells
  int globalKillCount = 0;
  
  // dirty way of giving the player a stock every 3 seconds
  if (millis() % 3000 <= 20) {
    meter.stock++;
  }
  
  // cell collision
  for (int i = 0; i < cells.length; i++) {
    cells[i].update();
    for (int j = 0; j < cells.length; j++) {
      if (j != i){
        cells[i].collide(cells[j]);
      }
    }
    cells[i].display();
    
    // checks to see how many cells are dead
    if (cells[i].energy <= 0) {
      globalKillCount++;
    }
    
    // checks to see if all 200 cells are dead; if so, the loop ends (reset with the 'r' key)
    if (globalKillCount == 200) {
      int score = (millis() - time);
      println("your score: ", score);
      println("please press the 'R' key to begin again");
      bgm.stop();
      noLoop();
    }
  }
  
  // using the same nested for loops for both parasites and antibodies, there are both 10 of them
  for (int p = 0; p < parasites.length; p++) {
      parasites[p].update();
      antibodies[p].update();
      for (int j = 0; j < cells.length; j++) {
        if (j != p) {
          parasites[p].attack(cells[j]);
          antibodies[p].heal(cells[j]);
        }
      }
      
      // displays parasites and antibodies
    parasites[p].display();   
    antibodies[p].display();
  }
  
  // displays antibody stocks
  meter.display();
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the brightest pixel
// in that frame and stores its location in brightestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }
  
  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float brightnessRecord = 0;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the brightness of the pixel we're looking at
      float pixelBrightness = brightness(pixelColor);
      // Check if this pixel is the brighest we've seen so far
      if (pixelBrightness > brightnessRecord) {
        // If it is, change the record value
        brightnessRecord = pixelBrightness;
        // Remember where this pixel is in the the grid of pixels
        // (and therefore on the screen) by setting the PVector
        // brightestPixel's x and y properties.
        brightestPixel.x = x;
        brightestPixel.y = y;
      }
    }
  }
}

// reset button
void keyPressed() {
  if (key == 'r') {
    bgm.stop();
    setup();
    time = millis();
    loop();
  }
}

// control for administering antibody
void mouseClicked() {
  if (meter.stock > 0) {
    pop.play();
    meter.stock--;
    for (int a = 0; a < 10; a++) {
      int x = mouseX;
      int y = mouseY;
      antibodies[a] = new Antibody (x, y, 20);
    }
  }
  else {
    return;
  }
}