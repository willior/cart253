// exercise 07: incorporating sound
//
// a game where parasites (blue) drain energy from your cells (red)
// release antibodies (yellow) by clicking on the screen to heal/revive your cells
// you are given 3 antibodies to start with, and receive an additional one every 3 seconds
// noise() function regulates objects' movement
// however, cell/antibody movement can be influenced with mouse movement
// used a timer to track "score"; the timer resets when the game is reset by pressing 'R'

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
  
  size(800,600);
  pop = new SoundFile(this,"pop.wav");
  bgm = new SoundFile(this,"bgm.mp3");
  
  // plays the background music in a loop
  bgm.loop();
  
  // player starts with 3 antibodies
  int stock = 3;
  meter = new Hyper(10, 50, (height - 50), stock, 0, hyperEmpty, hyperStroke);
  
  
  
  // instantiating cells
  for (int i = 0; i < cells.length; i++) {

    int x = floor(random(0, width));
    int y = floor(random(0, height));
    
    cells[i] = new Cell (x * 20, y * 20, 20);
  }
  
  // and parasites
  for (int p = 0; p < parasites.length; p++) {
    int x = floor(random(0, width));
    int y = floor(random(0, height));
    parasites[p] = new Parasite(x * 20, y * 20, 20);
    antibodies[p] = new Antibody (x, y, 20);
  }
}

void draw() {
  background(224);
  
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
    if (cells[i].energy == 0) {
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


void keyPressed() {
  
  // reset button
  if (key == 'r') {
    bgm.stop();
    setup();
    time = millis();
    loop();
  }
  
  // antibody release
  if (key == '1') {
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
    
}

// mouse clicked function
void mouseClicked() {
  
}