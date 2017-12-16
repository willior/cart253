// image library
PImage bossImage;
PImage splash;
PImage intro1;
PImage intro2;
PImage intro3;
PImage mainmenu;
PImage mainmenu_start;
PImage mainmenu_howto;
PImage credits;

boolean introRun;
boolean introOne;
boolean introTwo;
boolean introThree;

void setup() {
  size(800, 600);

  splash = loadImage("splash.png");
  intro1 = loadImage("intro1.png"); 
  intro2 = loadImage("intro2.png");
  intro3 = loadImage("intro3.png");
  mainmenu = loadImage("mainmenu.png");
  mainmenu_start = loadImage("mainmenu_start.png");
  mainmenu_howto = loadImage("mainmenu_howto.png");
  bossImage = loadImage("boss.png");
  credits = loadImage("credits.png");

  introRun = true;
  introOne = true;
  introTwo = true;
  introThree = true;
}

void intro() {
  
  fill(0);
  rect(0,0,50,50);
  
  background(0);
  
  if (introOne == true) {
    image(intro1, 0, 0);
    println("intro 1:");
    delay(1000);
    //for (int i = 0; i < 1000; i++) {
      
    //  println("intro 1:", i);
    //}
    // introOne = false;
  }

  if (introTwo == true) {
    image(intro2, 0, 0);
    println("intro 2:");
    delay(1000);
    //for (int i = 0; i <1000; i++) {
      
    //  println("intro 2:", i);
    //}
    // introTwo = false;
  }

  if (introThree == true) {
    // image(intro3, 0, 0);
    println("intro 3:");
    delay(1000);
    //for (int i = 0; i < 1000; i++) {
      
    //  println("intro 3:", i);
    //}
    // introThree = false;
  }
 
  // introRun = false;
  
  //menu = true;
  //coda.stop();
  //menu_bgm.loop();
}

void draw() {
  if (introRun == true) {
    intro();
  }
  
  else {
    fill(0);
    rect(50,50,width-50,height-50);
  }
}