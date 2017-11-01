// exercise 05
// goal: use the noise() function to regulate objects' movement
// added interactivity based on mouse position
// used a timer to track score

// import processing.sound.*;
// SoundFile pop;


Cell[] cells = new Cell[200];
Parasite[] parasites = new Parasite[10];
Antibody[] antibodies = new Antibody[10];

int time = 0;
int score = 0;

void setup() {
  
  size(800,600);
  
//  pop = new SoundFile(this,"pop.wav");
  
  for (int i = 0; i < cells.length; i++) {

    int x = floor(random(0, width));
    int y = floor(random(0, height));
    
    cells[i] = new Cell (x * 20, y * 20, 20);
  }
  for (int p = 0; p < parasites.length; p++) {
    int x = floor(random(0, width));
    int y = floor(random(0, height));
    parasites[p] = new Parasite(x * 20, y * 20, 20);
  }
}

void draw() {
  background(255);
  int globalKillCount = 0;
  
  for (int i = 0; i < cells.length; i++) {
    cells[i].update();
    for (int j = 0; j < cells.length; j++) {
      if (j != i){
        cells[i].collide(cells[j]);
      }
    }
    cells[i].display();
    if (cells[i].energy == 0) {
      globalKillCount++;
    }
    if (globalKillCount == 200) {
      int score = (millis() - time);
      println("your score: ", score);
      println("please click the screen to begin again");
      noLoop();
    }
  }
  
  
  for (int p = 0; p < parasites.length; p++) {
      parasites[p].update();
//      antibodies[p].update();
      for (int j = 0; j < cells.length; j++) {
        if (j != p) {
          parasites[p].attack(cells[j]);
//          antibodies[p].heal(cells[j]);
        }
      }
    parasites[p].display();   
//    antibodies[p].display();
  }
  
  
  
  //for (int a = 0; a < antibodies.length; a++) {
  //  antibodies[a].update();
  //  for (int b = 0; b < cells.length; b++) {
  //    if (a != b) {
  //      antibodies[a].heal(cells[b]);
  //    }
  //  }
  //  antibodies[a].display();
  //}
    
}

void keyPressed() {
  if (key == 'q') {
    setup();
    time = millis();
    loop();
  }
}

//void mouseClicked() {
//  for (int a=0; a < 10; a++) {
//    int x = mouseX;
//    int y = mouseY;
//    antibodies[a] = new Antibody (x, y, 20);
//  }
//}