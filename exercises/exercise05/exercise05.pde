Cell[] cells = new Cell[10];

void setup() {
  size(640,480);
  for (int i = 0; i < cells.length; i++) {

    int x = floor(random(0, 640));
    int y = floor(random(0, 480));
    
    cells[i] = new Cell (x * 20, y * 20, 20);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < cells.length; i++) {
    cells[i].update();
    for (int j = 0; j < cells.length; j++) {
      if (j != i){
        cells[i].collide(cells[j]);
      }
    }
    cells[i].display();
  }
}