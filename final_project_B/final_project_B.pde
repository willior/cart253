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
// noise() function regulates objects' movement, among other factors.
// which quadrant of the screen your cursor is in determines wind direction, influence cell movement.
// you can reset the game by pressing 'r'.
// hint: the boss's appendages must be disabled before you can damage its main body.
// try using your abilities in combination with each other.
// don't spam abilities. try to gain a few hyper stocks and use them in a rhythm.
// CHEAT CODES:
// you can disable all the parasites in the 1st phase and skip to the boss by pressing 'b'.
// you can sever all of the boss's minions by pressing 's' (warning: may freeze the game if used outside the boss battle)
// you can instantly kill the boss by pressing 'k'.
// have fun!!

/* 
 ARTIST STATEMENT
 
 I wanted to create a fast-paced, challenging-but-fair game with interesting visuals and musical audio feedback.
 There are so many interesting things in the coding I don't really know where to begin or what to focus on without going overboard.
 Notably, I'm glad I was able to incorporate the Boss element. Particularly the bezier tails and the Minions which exist on the end of them,
 as well as the fact that they must be severed before being able to damage the Boss.
 I would have liked to add more phases to the boss, changing sound effects and music as the boss evolves.
 In fact, I think an entire game could be made with this as the framework!
 I'm also quite happy with how the music/audio aspect worked out. Using abilities feels good, in part thanks to the sound effects.
 I placed a great emphasis on audiovisual feedback when attacking enemies and using abilities.
 This creates a stronger connection with the gameplay. It is very important when considering the feel of the game.
 I'm pleased with the transition from the parasite phase to the boss phase. It is a jarring, unexpected transition that startles the player.
 The audio for the boss phase came from a jam I was having with my friend a while back.
 
 
 */

// image library
PImage bossImage;
PImage splash;
PImage intro1;
PImage intro1b;
PImage intro2;
PImage intro3;
PImage mainmenu;
PImage mainmenu_start;
PImage mainmenu_howto;
PImage credits;

// sound library
import processing.sound.*;

SoundFile menu_bgm;
SoundFile ending;
SoundFile bgm;
SoundFile carlos;

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
SoundFile heal1b;
SoundFile heal2b;
SoundFile heal3b;
SoundFile heal4b;

SoundFile herd;
SoundFile empty;

SoundFile recharge1;
SoundFile recharge2;
SoundFile recharge3;
SoundFile recharge3b;
SoundFile recharge4;
SoundFile stun1;
SoundFile stun1b;
SoundFile stun2;
SoundFile stun3;
SoundFile stun4;
SoundFile disable;
SoundFile eat;

SoundFile coda;

// initializing arrays
Cell[] cells = new Cell[255];
Parasite[] parasites = new Parasite[10];
Antibody[] antibodies = new Antibody[40];
Minion[] minions = new Minion[8];


// initializing boss
Boss boss;

// background
color BG = color(255, 255, 255);

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

// initializing the variables that determine sequential order of certain sound effects
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

// variable that keeps track of the amount of minions severed
int severCount;

// variables for boss intro
int bossApproach;
int bossIntro;

// boolean to determine intro splash screens
boolean introRun;

// variables for startup sequence (not used)
int introCount;
int fadeCount1;
int fadeCount2;
int fadeCount3;
int fadeCount4;

// credits sequence
int creditRollX;
int creditRollY;
float endFade;

// boolean to determine menu screen
boolean menu;

boolean howToPlay;

// boolean to determine whether game should run or not (for splash screen)
boolean run;

// boolean to determine incoming boss
boolean incoming;

// bullshit
boolean bullshit;

void setup() {

  //introCount = 0;
  //fadeCount1 = 0;
  //fadeCount2 = 0;
  //fadeCount3 = 0;
  //fadeCount4 = 0;

  size(800, 600);

  splash = loadImage("splash.png");
  intro1 = loadImage("intro1.png"); 
  intro1b = loadImage("intro1b.jpg");
  intro2 = loadImage("intro2.png");
  intro3 = loadImage("intro3.png");
  mainmenu = loadImage("mainmenu.png");
  mainmenu_start = loadImage("mainmenu_start.png");
  mainmenu_howto = loadImage("mainmenu_howto.png");
  bossImage = loadImage("boss.png");
  credits = loadImage("credits.png");

  // boss intro 
  bossIntro = 1;
  bossApproach = 0;
  incoming = false;

  // resets number of parasites disabled to 0
  disableCount = 0;

  // resets number of minions severed to 0
  severCount = 0;
  menu_bgm = new SoundFile(this, "nerd.wav");
  ending = new SoundFile(this, "gravity.wav");
  bgm = new SoundFile(this, "bgm.mp3");
  carlos = new SoundFile(this, "carlos.mp3");

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
  heal1b = new SoundFile(this, "heal1b.wav");
  heal2b = new SoundFile(this, "heal2b.wav");
  heal3b = new SoundFile(this, "heal3b.wav");
  heal4b = new SoundFile(this, "heal4b.wav");

  herd = new SoundFile(this, "herd.wav");
  empty = new SoundFile(this, "empty.wav");

  recharge1 = new SoundFile(this, "recharge1.wav");
  recharge2 = new SoundFile(this, "recharge2.wav");
  recharge3 = new SoundFile(this, "recharge3.wav");
  recharge3b = new SoundFile(this, "recharge3b.wav");
  recharge4 = new SoundFile(this, "recharge4.wav");
  stun1 = new SoundFile(this, "stun1.wav");
  stun1b = new SoundFile(this, "stun1b.wav");
  stun2 = new SoundFile(this, "stun2.wav");
  stun3 = new SoundFile(this, "stun3.wav");
  stun4 = new SoundFile(this, "stun4.wav");
  eat = new SoundFile(this, "eat.wav");
  disable = new SoundFile(this, "disable.wav");

  coda = new SoundFile(this, "coda.mp3");

  // boolean to prevent the game from running on setup()
  // also used for the pause function ('p')
  run = false;

  // runs intro on setup
  introRun = true;

  menu = false;

  bullshit = true;

  creditRollX = 0;
  creditRollY = 600;

  endFade = 0;

  // player starts with 3 antibodies
  int stock = 3;
  int eLevel = 0;
  meter = new Hyper(10, 50, (height - 50), stock, 0, hyperEmpty, hyperStroke);

  // instantiates the Energy bar for herding cells
  bar = new Energy(110, 10, 50, (height - 30), eLevel, 0, energyEmpty, energyStroke);

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
  }

  // and antibodies
  for (int a = 0; a < antibodies.length; a++) {
    int x = floor(random(0, width));
    int y = floor(random(0, height));
    antibodies[a] = new Antibody(x, y, 20);
  }
}

// flow:
// cells update
// cells collide (hitbox detection)
// cells display
// parasites/antibodies update
// parasites/antibodies attack/heal (hitbox detection)
// parasites/antibodies display

// intro sequence
// not functioning: does not display the images at all
// i wanted to fade in and out of each intro image (intro1.png, intro2.png, etc) ...
// ... and into the main menu, but i cannot get it to work for the life of me
// the for loops run, as you can tell in the console
// but the images simply do not show up and i can't seem to figure out why
void intro() {

  coda.play();

  // why doen't the images display?
  println("intro1.png");
  image(intro1, 0, 0);
  delay(1000);
  println("intro2.png");
  image(intro2, 0, 0);
  delay(1000);
  println("intro3.png");
  image(intro3, 0, 0);
  delay(1000);


  introRun = false;
  menu = true;
  coda.stop();
  menu_bgm.loop();
}

void draw() {

  fill(0);
  rect(0, 0, width, height);

  // added a bullshit step to see if it did anything
  // it didn't
  if (bullshit == true) {
    for (int i = 0; i < 1; i++) {
      println("i am going insane");
    }

    if (introRun == true) {

      // intro not displaying images; why not?
      intro();
    }

    bullshit = false;
  }



  // main menu
  if (menu == true) {

    image(mainmenu, 0, 0);
    if ((mouseX > 610)&&(mouseY > 310)&&(mouseX < 750)&&(mouseY < 350)) {
      image(mainmenu_start, 0, 0);
      if (mousePressed == true) {
        menu = false;
        bgm.loop();
      }
    }

    if (howToPlay == true) {
      image(splash, 0, 0);
    } else if ((mouseX > 440)&&(mouseY > 430)&&(mouseX < 750)&&(mouseY < 490)) {
      image(mainmenu_howto, 0, 0);
      if (mousePressed == true) {
        howToPlay = true;
      }
    }
    return;
  }

  if (menu == false) {
    run = true;
    menu_bgm.stop();
  }

  if (disableCount<10) {
    background(BG);
  }
  if (disableCount>10) {
    background(24);
  }

  if (run == false) {

    // pause screen goes here
    image(splash, 0, 0);
  }

  // used to start the game, now does nothing
  // if ((mousePressed == true)&&(menu == false)) {
  // }  

  // runs the main code in draw() on mousePressed
  if (run == true) {

    // behaviour for the parasite stun timer
    stunTime--;
    stunTime = constrain(stunTime, 0, 100);

    // returns parasite stun state as false if stunTimer is 0
    if ((stunTime == 0) && (disableCount < 10)) {
      for (int p = 0; p < 10; p++) {
        parasites[p].stun = false;
      }
    }
    if ((stunTime == 0) && (disableCount > 10)) {
      for (int m = 0; m < 8; m++) {
        minions[m].stun = false;
      }
      boss.stun = false;
    }

    // resets variable to store the amount of dead cells
    globalKillCount = 0;

    // dirty way of giving the player a stock every 1.1 seconds
    if (millis() % 1100 <= 20) {
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

      // game over: checks to see if all 255 cells are dead (parasite phase)
      if ((globalKillCount == 255)&&(disableCount<10)) {
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

      // game over: checks to see if all 255 cells are dead (boss phase)
      else if ((globalKillCount == 255)&&(disableCount>10)) {

        run = false;
        noLoop();
      }
    }

    // resets variable storing disabled parasite information
    if (disableCount <= 10) {
      disableCount = 0;
    }

    // checks to see how many parasites are disabled
    for (int p = 0; p < parasites.length; p++) {
      if (parasites[p].eatCount > 64) {
        disableCount++;
        disableCount = constrain(disableCount, 0, 11);
      }
    }

    // end state
    if (severCount == 8) {
      if (boss.energy <= 0) {

        carlos.stop();     
        if (creditRollY == 600) {
          ending.play();
        }
        image(intro3, 0, 0);
        image(credits, creditRollX, creditRollY);
        creditRollY--;
        creditRollY = constrain(creditRollY, -932, 600);
        boss.display();

        // credits stop       
        if (creditRollY == -932) {
          fill(0, 0, 0, endFade);
          noStroke();
          rect(515, 0, 515, 162);
          endFade += 0.8;
        }
        if (endFade >= 255) {
          noLoop();
        }
        return;
      }
    }

    // boss intro screen runs after all parasites are disabled
    if (disableCount == 10) {

      // clause to escape from intro screen
      if (bossApproach < 0) {
        bossIntro = -1;
        disableCount++;
      }

      // variable determining amount of time boss intro screen is;
      if (bossIntro == 1) {
        bossApproach = 329;

        // stops phase 1 BGM, starts phase 2 BGM
        bgm.stop();
        carlos.play();

        // instantiating boss...
        boss = new Boss(width/2, height/2, 200);

        // and minions
        for (int m=0; m<8; m++) {
          minions[m] = new Minion (boss.mx[m], boss.my[m], 16, m);
        }
      }

      // the boss intro screen itself
      if (bossApproach > 0) {
        image(bossImage, 0, 0);
        bossIntro = 0;
        bossApproach--;
        bossApproach--;
        bossApproach--;
      }
    }

    // boss functions; runs after boss intro
    if (bossIntro == -1) {
      boss.update();
      for (int i = 0; i < cells.length; i++) {
        boss.attack(cells[i]);
      }
      boss.display();

      // minion functions
      for (int m = 0; m < minions.length; m++) {
        minions[m].update();
        for (int a = 0; a < cells.length; a++) {
          if (a != m) {
            minions[m].attack(cells[a]);
          }
        }
        minions[m].display();
      }
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
      bar.eLevel -= 1.6;

      // stops the harmonic tone once energy becomes depleted
      if (bar.eLevel < 1.6) {
        herd.stop();
        depleted = true;
      } 

      // the depleted boolean value is not yet used
      else {
        depleted = false;
      }
    }

    // regenerates energy over time, constrains their values, displays energy bar
    bar.eLevel += 0.8;
    bar.eLevel = constrain(bar.eLevel, 0, 110);
    bar.display();

    // displays ability stocks
    meter.display();
  }

  // breaks out of draw() until mouseClicked, changing run to true
  while (run == false) {
    return;
  }
}

void keyPressed() {

  // kills boss instantly ('k')
  if (key == 'k') {
    boss.energy = 0;
  }

  // disable all parasites button ('b')
  // quick way to skip to the boss for testing purposes
  if (key == 'b') {
    for (int b = 0; b < 10; b++) {
      parasites[b].eatCount = 65;
    }
  }

  // sever all minions button ('s')
  // quick way to skip phase 1 of the boss for testing purposes
  if (key == 's') {
    for (int s = 0; s < 8; s++) {
      minions[s].eatCount = 129;
    }
    severCount = 8;
  }

  // reset button ('r')
  if (key == 'r') {
    if (disableCount < 10) {
      bgm.stop();
    }
    if (globalKillCount == 255) {
      coda.stop();
    }
    if (disableCount > 10) {
      carlos.stop();
    }

    // checking for boss.energy needs to be embedded after checking disableCount
    // it crashes otherwise since the boss doesn't get created until after the parasites are disabled
    if (disableCount > 10) {
      if (boss.energy <= 0) {
        ending.stop();
      }
    }
    if (menu == true) {
      return;
    } else {
      setup();
      time = millis();
      loop();
    }
  }

  // pause button ('p')
  if (key == 'p') {
    run = false;
  }

  // antibody release
  // releases 10 antibodies at the location of the cursor when the '1' key is pressed
  if (key == '1') {
    if (meter.stock > 0) {

      // sound picker for antibody release (pre-boss)
      if (disableCount<10) {
        if (antibodySFXseed == 0) {
          bloom1.play();

          for (int a = 0; a < 10; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 1) {
          bloom2.play();

          for (int a = 10; a < 20; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 2) {
          bloom3.play();

          for (int a = 20; a < 30; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 3) {
          bloom4.play();

          for (int a = 30; a < 40; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        antibodySFXseed++;
        if (antibodySFXseed == 4) {
          antibodySFXseed = 0;
        }
      }
      // sound picker for antibody release (during boss)
      if (disableCount>10) {
        if (antibodySFXseed == 0) {
          // bloom1b.play();

          for (int a = 0; a < 10; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 1) {
          // bloom2b.play();

          for (int a = 10; a < 20; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 2) {
          // bloom3b.play();

          for (int a = 20; a < 30; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        if (antibodySFXseed == 3) {
          // bloom4b.play();

          for (int a = 30; a < 40; a++) {
            int x = mouseX;
            int y = mouseY;
            antibodies[a] = new Antibody (x, y, 20);
          }
        }
        antibodySFXseed++;
        if (antibodySFXseed == 4) {
          antibodySFXseed = 0;
        }
      }

      meter.stock--;
    } else {
      return;
    }
  }

  // energy recharge (uses 1 hyper stock)
  if (key =='2') {
    if (meter.stock > 0) {
      meter.stock--;
      bar.eLevel = 110;

      if (rechargeSFXseed == 0) {
        recharge1.play();
      }
      if (rechargeSFXseed == 1) {
        recharge2.play();
      }
      if (rechargeSFXseed == 2) {
        recharge3.play();
      }
      if (rechargeSFXseed == 3) {
        recharge4.play();
      }

      // variable used to cycle sequentially through sound effects
      rechargeSFXseed++;
      if (rechargeSFXseed == 4) {
        rechargeSFXseed = 0;
      }

      // makes sure the harmonic tone for herding plays after rejuvinating herding energy if the mouse is already held down
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

      if ((stunSFXseed == 0)&&(disableCount<10)) {
        stun1.play();
      } else if ((stunSFXseed == 0)&&(disableCount>10)) {
        stun1b.play();
      }
      if (stunSFXseed == 1) {
        stun2.play();
      }
      if (stunSFXseed == 2) {
        stun3.play();
      }
      if (stunSFXseed == 3) {
        stun4.play();
      }

      // variable used to cycle sequentially through sound effects
      stunSFXseed++;
      if (stunSFXseed == 4) {
        stunSFXseed = 0;
      }

      // sets the stun time, keeps parasites/boss stunned while stunTime is greater than 0
      // 
      // stun behaviour versus parasites
      stunTime = 80;
      if ((stunTime >= 1)&&(disableCount<10)) {
        for (int p = 0; p < 10; p++) {
          parasites[p].stun = true;
        }
      }

      // stun behaviour versus boss (stun slightly less effective)
      if ((stunTime >= 1)&&(disableCount>=10)) {
        stunTime = 72;
        for (int m = 0; m < 8; m++) {
          boss.stun = true;
          minions[m].stun = true;
        }
      }
    }
  }
}

// mouse clicked function
void mousePressed() {

  if (menu == true) {
  }

  if (howToPlay == true) {
    howToPlay = false;
  }

  if (run == true) {
    // plays a harmonic tone
    herd.loop();
    // plays non-harmonic noise
    empty.loop();
  } else if (run == false) {
    run = true;
  }
}

// mouse released function
void mouseReleased() {

  if (run == true) {
    // stops both harmonic tone and non-harmonic noise
    herd.stop();
    empty.stop();
  }
}