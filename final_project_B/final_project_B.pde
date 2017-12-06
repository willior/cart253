// will graham-simpkins //<>//
// cart253
// final project
//
// a game where parasites (blue) drain energy from your cells (red).
// you are given 3 hyper stocks to start with, and receive an additional one every 3 seconds (max 6).
// hyper stocks (the red squares) are spent to use abilities (the '1', '2', and '3' keys).
// you can store a maximum of 6 hyper stocks at any given moment.
// release antibodies (yellow) at the location of your cursor by pressing your '1' key (expends one hyper stock)
// antibodies heal/revive your cells based on how much energy they have left.
// clicking on the screen herds your cells together, but it expends energy (green bar).
// energy recharges over time.
// press '2' to instantly recharge your herding energy (expends one hyper stock).
// press '3' to stun the parasites for a short amount of time (expends one hyper stock).
// disable parasites by feeding them cells while they are stunned.
// overlapping cells heal each other slowly. the more overlapping, the faster the healing.
// noise() function regulates objects' movement, among other factors.
// which quadrant of the screen your cursor is in determines wind direction, influence cell movement.
// used a timer to track "score"; the timer resets when the game is reset by pressing 'R'.
// click on the splash screen to start the game.
// have fun!!

// sound library
import processing.sound.*;
SoundFile bgm;

SoundFile bloom1;
SoundFile bloom2;
SoundFile bloom3;
SoundFile bloom4;

SoundFile kill1;
SoundFile kill2;
SoundFile kill3;
SoundFile kill4;
SoundFile kill5;
SoundFile kill6;
SoundFile kill7;
SoundFile kill8;
SoundFile kill9;

SoundFile heal1;
SoundFile heal2;
SoundFile heal3;
SoundFile heal4;

SoundFile herd;
SoundFile empty;

SoundFile recharge1;
SoundFile recharge2;
SoundFile recharge3;
SoundFile recharge4;
SoundFile stun1;
SoundFile stun2;
SoundFile stun3;
SoundFile stun4;
SoundFile disable;
SoundFile eat;

SoundFile coda;

// initializing arrays
Cell[] cells = new Cell[255];
Parasite[] parasites = new Parasite[10];
Antibody[] antibodies = new Antibody[10];

// initializing boss
Boss boss;

// creating the meter to display antibody stock
Hyper meter;
color hyperEmpty = color(255);
color hyperStroke = color(0);

// creating the energy meter to display energy
Energy bar;
color energyEmpty = color(255);
color energyStroke = color(0);

// variables for time and score
int time = 0;
int score = 0;

// variable for parasite stun timer
int stunTime;

// global variables for velocities
float vx;
float vy;

// initializing the number that determines Antibody release sound effects
// not actually a "seed" in terms of randomness but you get the idea
int antibodySFXseed = 0;
int rechargeSFXseed = 0;
int stunSFXseed = 0;

// boolean to determine whether energy remains or not; not yet used
boolean depleted;

// variable that keeps track of the amount of cells currently dead
int globalKillCount;

// variable that keeps track of the amount of parasites disabled
int disableCount;

// boolean to determine whether game should run or not (for splash screen)
boolean run;

void setup() {

  size(800, 600);

  bgm = new SoundFile(this, "bgm.mp3");

  bloom1 = new SoundFile(this, "bloom1.wav");
  bloom2 = new SoundFile(this, "bloom2.wav");
  bloom3 = new SoundFile(this, "bloom3.wav");
  bloom4 = new SoundFile(this, "bloom4.wav");

  kill1 = new SoundFile(this, "kill1.wav");
  kill2 = new SoundFile(this, "kill2.wav");
  kill3 = new SoundFile(this, "kill3.wav");
  kill4 = new SoundFile(this, "kill4.wav");
  kill5 = new SoundFile(this, "kill5.wav");
  kill6 = new SoundFile(this, "kill6.wav");
  kill7 = new SoundFile(this, "kill7.wav");
  kill8 = new SoundFile(this, "kill8.wav");
  kill9 = new SoundFile(this, "kill9.wav");

  heal1 = new SoundFile(this, "heal1.wav");
  heal2 = new SoundFile(this, "heal2.wav");
  heal3 = new SoundFile(this, "heal3.wav");
  heal4 = new SoundFile(this, "heal4.wav");

  herd = new SoundFile(this, "herd.wav");
  empty = new SoundFile(this, "empty.wav");

  recharge1 = new SoundFile(this, "recharge1.wav");
  recharge2 = new SoundFile(this, "recharge2.wav");
  recharge3 = new SoundFile(this, "recharge3.wav");
  recharge4 = new SoundFile(this, "recharge4.wav");
  stun1 = new SoundFile(this, "stun1.wav");
  stun2 = new SoundFile(this, "stun2.wav");
  stun3 = new SoundFile(this, "stun3.wav");
  stun4 = new SoundFile(this, "stun4.wav");
  eat = new SoundFile(this, "eat.wav");
  disable = new SoundFile(this, "disable.wav");

  coda = new SoundFile(this, "coda.mp3");

  // boolean to prevent the game from running on setup()
  run = false;

  // plays the background music in a loop
  bgm.loop();

  // player starts with 3 antibodies
  int stock = 3;
  int eLevel = 0;
  meter = new Hyper(10, 50, (height - 50), stock, 0, hyperEmpty, hyperStroke);

  // instantiates the Energy bar for herding cells
  bar = new Energy(110, 10, 50, (height - 30), eLevel, 0, energyEmpty, energyStroke);

  // and boss
  boss = new Boss(width/2, height/2, 200);

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

// flow:
// cells update
// cells collide (hitbox detection)
// cells display
// parasites/antibodies update
// parasites/antibodies attack/heal (hitbox detection)
// parasites/antibodies display

void draw() {

  background(255);
  // background(255-globalKillCount);
  // splash screen goes here

  // changes the boolean run value to true value on mousePressed (starts the game)
  if (mousePressed == true) {
    run = true;
  }  

  // runs the main code in draw() on mousePressed
  if (run == true) {

    // behaviour for the parasite stun timer
    stunTime--;
    stunTime = constrain(stunTime, 0, 100);

    // returns parasite stun state as false if stunTimer is 0
    if (stunTime == 0) {
      for (int p = 0; p < 10; p++) {
        parasites[p].stun = false;
      }
      boss.stun = false;
    }

    // resets variable to store the amount of dead cells
    globalKillCount = 0;

    // dirty way of giving the player a stock every 3 seconds
    if (millis() % 1000 <= 20) {
      meter.stock++;
    }

    // cells update
    for (int i = 0; i < cells.length; i++) {
      cells[i].update();

      // cell collision
      for (int j = 0; j < cells.length; j++) {
        if (j != i) {
          cells[i].collide(cells[j]);
        }
      }
      cells[i].display();

      // checks to see how many cells are dead
      if (cells[i].energy <= 0) {
        globalKillCount++;
      }

      // checks to see if all 255 cells are dead; if so, the loop ends (reset with the 'r' key)
      if (globalKillCount == 255) {
        int score = (millis() - time);
        println("your score: ", score);
        println("please press the 'R' key to begin again");
        background(0, 0, 0);
        bgm.stop();
        coda.play();
        for (int d = 0; d < parasites.length; d++) {
          parasites[d].display(); 
          {
            ellipseMode(CENTER);
            for (int e = 0; e < 10; e++) {
              fill(255, 0, 0, 32); 
              stroke(0, 0, 0, 32);
              ellipse(parasites[d].x+e*16-400, parasites[d].y+e*16-400, 84+(parasites[d].killCount/2), 84+(parasites[d].killCount/2));
              fill(255, 0, 0, 32); 
              stroke(255, 255, 255, 127);
              ellipse(parasites[d].x+e*24, parasites[d].y+e*24, 168+(parasites[d].killCount/2), 168+(parasites[d].killCount/2));
            }
          }
        }
        fill(255, 255, 255);
        textSize(256); // Font size
        textAlign(CENTER, CENTER); // Center align both horizontally and vertically
        textLeading(192); // Line height for text
        text("game\nover", width/2, height/2); // Note that \n means "new line"
        run = false;
        noLoop();
      }
    }
    
    // resets variable storing disabled parasite information
    disableCount = 0;

    // checks to see how many parasites are disabled
    for (int p = 0; p < parasites.length; p++) {
      if (parasites[p].eatCount > 50) {
        disableCount++;
        println(disableCount);
      }
    }

    // boss functions; only runs if all parasites are disabled
    if (disableCount == 10) {    
      boss.update();
      for (int i = 0; i < cells.length; i++) {
        boss.attack(cells[i]);
      }
      boss.display();
    }

    // parasite functions; only runs if all parasites are not disabled
    else if (disableCount < 10) { 
      for (int p = 0; p < parasites.length; p++) {
        parasites[p].update();
        for (int j = 0; j < cells.length; j++) {
          if (j != p) {
            parasites[p].attack(cells[j]);
          }
        }
        parasites[p].display();
      }
    }

    // antibody functions
    for (int a = 0; a < antibodies.length; a++) {
      antibodies[a].update();
      for (int j = 0; j < cells.length; j++) {
        if (j != a) {
          antibodies[a].heal(cells[j]);
        }
      }
      antibodies[a].display();
    }

    // drains energy when mouse is held
    // for some reason, this would not work when embedded into the Energy class's update() function, so it goes here
    if (mousePressed == true) {

      // drains energy from the meter
      bar.eLevel -= 1.5;

      // stops the harmonic tone once energy becomes depleted
      if (bar.eLevel < 1.5) {
        herd.stop();
        depleted = true;
      } 

      // the depleted boolean value is not yet used
      else {
        depleted = false;
      }
    }

    // regenerates energy over time, constrains their values, displays energy bar
    bar.eLevel += 1;
    bar.eLevel = constrain(bar.eLevel, 0, 110);
    // println(bar.eLevel);
    bar.display();

    // displays ability stocks
    meter.display();
  }

  // breaks out of draw() until mouseClicked
  while (run == false) {
    return;
  }
}

void keyPressed() {
  
  // disable all parasites button ('b')
  // quick way to skip to the boss for testing purposes
  if (key == 'b') {
    for (int b = 0; b < 10; b++) {
      
      parasites[b].eatCount = 51;
    } 
  }

  // reset button ('r')
  if (key == 'r') {
    bgm.stop();
    coda.stop(); 
    setup();
    time = millis();
    loop();
  }

  // antibody release
  if (key == '1') {
    if (meter.stock > 0) {

      // sound picker for antibody release
      if ((antibodySFXseed >= 0) && (antibodySFXseed < 1)) {
        bloom1.play();
      }
      if ((antibodySFXseed >= 1) && (antibodySFXseed < 2)) {
        bloom2.play();
      }
      if ((antibodySFXseed >= 2) && (antibodySFXseed < 3)) {
        bloom3.play();
      }
      if ((antibodySFXseed >= 3) && (antibodySFXseed <= 4)) {
        bloom4.play();
      }
      antibodySFXseed++;
      if (antibodySFXseed == 4) {
        antibodySFXseed = 0;
      }
      meter.stock--;

      // releases 10 antibodies at the location of the cursor when the '1' key is pressed.
      for (int a = 0; a < 10; a++) {
        int x = mouseX;
        int y = mouseY;
        antibodies[a] = new Antibody (x, y, 20);
      }
    } else {
      return;
    }
  }

  // energy recharge (uses 1 hyper stock)
  if (key =='2') {
    if (meter.stock > 0) {
      meter.stock--;
      bar.eLevel = 110;

      if ((rechargeSFXseed >= 0) && (rechargeSFXseed < 1)) {
        recharge1.play();
      }
      if ((rechargeSFXseed >= 1) && (rechargeSFXseed < 2)) {
        recharge2.play();
      }
      if ((rechargeSFXseed >= 2) && (rechargeSFXseed < 3)) {
        recharge3.play();
      }
      if ((rechargeSFXseed >= 3) && (rechargeSFXseed <= 4)) {
        recharge4.play();
      }

      // variable used to cycle sequentially through sound effects
      rechargeSFXseed++;
      if (rechargeSFXseed == 4) {
        rechargeSFXseed = 0;
      }

      // recharge1.play();

      // makes sure the harmonic tone for herding plays after rejuvinating herding energy if the mouse is already pressed
      if (mousePressed == true) {

        // prevents more than 1 instance of the tone from playing at once
        herd.stop();
        herd.loop();
      }
    }
  }

  // parasite stun ability (uses 1 hyper stock)
  if (key =='3') {
    if (meter.stock > 0) {
      meter.stock--;

      if ((stunSFXseed >= 0) && (stunSFXseed < 1)) {
        stun1.play();
      }
      if ((stunSFXseed >= 1) && (stunSFXseed < 2)) {
        stun2.play();
      }
      if ((stunSFXseed >= 2) && (stunSFXseed < 3)) {
        stun3.play();
      }
      if ((stunSFXseed >= 3) && (stunSFXseed <= 4)) {
        stun4.play();
      }

      // variable used to cycle sequentially through sound effects
      stunSFXseed++;
      if (stunSFXseed == 4) {
        stunSFXseed = 0;
      }
      // sets the stun time to 100, and keeps the parasites/boss stunned while stunTime is greater than 0
      stunTime = 100;
      if ((stunTime >= 1)&&(disableCount<10)) {
        for (int p = 0; p < 10; p++) {
          parasites[p].stun = true;
        }
      }
      if ((stunTime >= 1)&&(disableCount==10)) {
        
        // halved stun time against the boss
        stunTime = 50;
        for (int p = 0; p < 10; p++) {
          boss.stun = true;
        }
      }
    }
  }
}


// mouse clicked function
void mousePressed() {

  // plays a harmonic tone
  herd.loop();
  // plays non-harmonic noise
  empty.play();
}

// mouse released function
void mouseReleased() {

  // stops both harmonic tone and non-harmonic noise
  herd.stop();
  empty.stop();
}