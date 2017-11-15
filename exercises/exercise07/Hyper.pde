// Hyper
//
// A class that defines 6 small boxes to determine the amount of antibodies they have in stock

class Hyper {

  // declaration of variables to be used by the Hyper class
  int hyperSize;
  int hyperX;
  int hyperY;
  int stock;
  int hyperMode;
  char hyperKey;

  // the colour of a full hyper stock (red)
  color hyperFull = color(255, 0, 0);

  // colour properties for the Hyper class
  color hyperEmpty;
  color hyperStroke;

  // HYPER CONSTRUCTOR also my new nickname
  Hyper(int _hyperSize, int _hyperX, int _hyperY, int _stock, int _hyperMode, color _hyperEmpty, color _hyperStroke) {

    hyperSize = _hyperSize;
    hyperX = _hyperX;
    hyperY = _hyperY;
    stock = _stock;
    hyperMode = _hyperMode;
    hyperEmpty = _hyperEmpty;
    hyperStroke = _hyperStroke;
  }

  // setting properties for the display of the hyper stocks
  void display() {
    stroke(hyperStroke);
    fill(hyperEmpty);
    rectMode(CORNER);

    if (stock > 6) {
      stock = 6;
    }

    // formatting the display of the hyper stocks

    if (stock == 6) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 5) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 4) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 3) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 2) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 1) {
      fill(hyperFull);
      rect(hyperX, hyperY, hyperSize, hyperSize);
      fill(hyperEmpty);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    } else if (stock == 0) {
      rect(hyperX, hyperY, hyperSize, hyperSize);
      rect(hyperX+20, hyperY, hyperSize, hyperSize);
      rect(hyperX+40, hyperY, hyperSize, hyperSize);
      rect(hyperX+60, hyperY, hyperSize, hyperSize);
      rect(hyperX+80, hyperY, hyperSize, hyperSize);
      rect(hyperX+100, hyperY, hyperSize, hyperSize);
    }
  }
}