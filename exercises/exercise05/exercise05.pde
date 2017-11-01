// exercise 05
// goal: use the noise() function to regulate objects' movement
// added interactivity based on mouse position
// used a timer to track "score"

 import processing.sound.*;
 SoundFile pop;


Cell[] cells = new Cell[200];
Parasite[] parasites = new Parasite[10];
Antibody[] antibodies = new Antibody[10];

int time = 0;
int score = 0;

void setup() {
  
  size(800,600);
  
  pop = new SoundFile(this,"pop.wav");
  
  for (int i = 0; i < cells.length; i++) {

    int x = floor(random(0, width));
    int y = floor(random(0, height));
    
    cells[i] = new Cell (x * 20, y * 20, 20);
  }
  for (int p = 0; p < parasites.length; p++) {
    int x = floor(random(0, width));
    int y = floor(random(0, height));
    parasites[p] = new Parasite(x * 20, y * 20, 20);
    antibodies[p] = new Antibody (x, y, 20);
  }
}

void draw() {
  background(255);
  
  // variable to store the amount of dead cells
  int globalKillCount = 0;
  
  
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
    
    // checks to see if all 200 cells are dead; if so, the loop ends (reset with the 'q' key)
    if (globalKillCount == 200) {
      int score = (millis() - time);
      println("your score: ", score);
      println("please click the screen to begin again");
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
    parasites[p].display();   
    antibodies[p].display();
  }
}
  
void keyPressed() {
  if (key == 'q') {
    setup();
    time = millis();
    loop();
  }
}

void mouseClicked() {
  pop.play();
  for (int a = 0; a < 10; a++) {
    int x = mouseX;
    int y = mouseY;
    antibodies[a] = new Antibody (x, y, 20);
  }
}