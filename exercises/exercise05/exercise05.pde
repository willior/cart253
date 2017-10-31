Cell[] cells = new Cell[200];
Parasite[] parasites = new Parasite[10];

void setup() {
  size(640,480);
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
  for (int i = 0; i < cells.length; i++) {
    cells[i].update();
    for (int j = 0; j < cells.length; j++) {
      if (j != i){
        cells[i].collide(cells[j]);
      }
    }
    cells[i].display();
  }
  for (int p = 0; p < parasites.length; p++) {
      parasites[p].update();
      for (int j = 0; j < cells.length; j++) {
        if (j != p) {
          parasites[p].attack(cells[j]);    
        }
      }
    // Display the parasites
    parasites[p].display();
  }
}