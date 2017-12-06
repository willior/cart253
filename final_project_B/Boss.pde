// Boss
//
// a class that defines the boss that appears when all parasites have been disabled
class Boss {

  int drainEnergy = 20;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 8;
  float x;
  float y;

  float killCount = 0;
  float sizeOffset;
  int eatCount = 0;

  float killSFXseed;

  boolean stun;

  color fill = color(0, 0, 255);
  color fed = color(255,0,255);

  Boss(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }
  
  void update() {
    
    if (bossApproach > 0){
      return;
    }
      
    if (eatCount > 500) {
      
      // you win?
      
    }

    else if (stun == false) {

      // created a new variable, sizeOffset, to modulate both the parasite hitbox and size based off each parasite's kill count
      sizeOffset = killCount/4;
      sizeOffset += eatCount*2;

      // constrains the sizeOffset variable to remain within a reasonable range; otherwise, the parasites become too big and the game becomes impossible very quickly
      sizeOffset = constrain (sizeOffset, 0, 512);

      float vx = speed * (noise(tx) * 2 - 1);
      float vy = speed * (noise(ty) * 2 - 1);
      x += vx;
      y += vy;

      tx += 0.01;
      ty += 0.01;

      if (x < 0) {
        x += width;
      } else if (x >= width) {
        x -= width;
      }
      if (y < 0) {
        y += height;
      } else if (y >= height) {
        y -= height;
      }
    }
    else if (stun == true) {

    }
  }

  // boss attack function
  void attack(Cell host) {
    
    // overrides attack function by returning if "fed"
    if (eatCount > 500) {
      return;
    }

    if (stun == false) {

      // boss hitbox logic
      if ((x == host.x && y == host.y) || (x <= host.x + (10+(sizeOffset/4)) && y <= host.y + (10+(sizeOffset/4)) && (x >= host.x - (10+(sizeOffset/4)) && y >= host.y - (10+(sizeOffset/4))))) {

        // breaks out of function if host cell is "confirmed dead" (ie, less than 0)
        if (host.energy < 0) {
          return;
        }

        // else runs the attack function
        else {

          // drains energy from host cell
          host.energy -= drainEnergy;

          // constrains energy to not go below 0
          // for clarification, a cell whose energy = 0 at this point in the program flow is known [semantically] as "killed", ie. they die in the current cycle
          // cells whose energy level is LESS than 0 at any point are known [semantically] as "confirmed dead"

          host.energy = constrain(energy, 0, 255);

          if (host.energy == 0) {

            // picks a kill sound at random form the library
            killSFXseed = random(0, 9);
            if ((killSFXseed >= 0) && (killSFXseed <= 1)) {
              kill1.play();
            }
            if ((killSFXseed > 1) && (killSFXseed <= 2)) {
            //  kill2.play();
            }
            if ((killSFXseed > 2) && (killSFXseed <= 3)) {
            //  kill3.play();
            }
            if ((killSFXseed > 3) && (killSFXseed <= 4)) {
              kill4.play();
            }
            if ((killSFXseed > 4) && (killSFXseed <= 5)) {
            //  kill5.play();
            }
            if ((killSFXseed > 5) && (killSFXseed <= 6)) {
            //  kill6.play();
            }
            if ((killSFXseed > 6) && (killSFXseed <= 7)) {
              kill7.play();
            }
            if ((killSFXseed > 7) && (killSFXseed <= 8)) {
            //  kill8.play();
            }
            if ((killSFXseed > 8) && (killSFXseed <= 9)) {
            //  kill9.play();
            }

            // updates boss kill count
            killCount++;

            // updates the energy of the "killed" cell (host.energy = 0) to "confirmed dead" cell (host.energy = -1)
            // which prevents "killed" logic from running anymore
            host.energy = -1;
          }
        }
      }
    }
    
    // hitbox behaviour while boss stunned
    else if (stun == true) {
      
      if ((x == host.x && y == host.y) || (x <= host.x + (10+(sizeOffset/4)) && y <= host.y + (10+(sizeOffset/4)) && (x >= host.x - (10+(sizeOffset/4)) && y >= host.y - (10+(sizeOffset/4))))) {

        // breaks out of function if host cell is "confirmed dead" (ie, less than 0)
        if (host.energy < 0) {
          return;
        }

        // else runs the attack function
        else {

          // drains energy from host cell
          host.energy -= drainEnergy;

          // constrains energy to not go below 0
          // for clarification, a cell whose energy = 0 at this point in the program flow is known [semantically] as "killed", ie. they die in the current cycle
          // cells whose energy level is LESS than 0 at any point are known [semantically] as "confirmed dead"

          host.energy = constrain(energy, 0, 255);

          if (host.energy == 0) {

            // picks a kill sound at random form the library
            killSFXseed = random(0, 9);
            if ((killSFXseed >= 0) && (killSFXseed <= 1)) {
              // kill1.play();
            }
            if ((killSFXseed > 1) && (killSFXseed <= 2)) {
              // kill2.play();
            }
            if ((killSFXseed > 2) && (killSFXseed <= 3)) {
              kill3.play();
            }
            if ((killSFXseed > 3) && (killSFXseed <= 4)) {
              // kill4.play();
            }
            if ((killSFXseed > 4) && (killSFXseed <= 5)) {
              // kill5.play();
            }
            if ((killSFXseed > 5) && (killSFXseed <= 6)) {
              kill6.play();
            }
            if ((killSFXseed > 6) && (killSFXseed <= 7)) {
              // kill7.play();
            }
            if ((killSFXseed > 7) && (killSFXseed <= 8)) {
              // kill8.play();
            }
            if ((killSFXseed > 8) && (killSFXseed <= 9)) {
              kill9.play();
            }

            // updates parasite eat count and plays appropriate sound effect
            eatCount++;
            
            // visual feedback
            stroke(255);
            fill(255-(eatCount%2),127-eatCount%20,eatCount%8,12);
            ellipse(x, y, 128+(sizeOffset/2), 128+(sizeOffset));
            fill(255-(eatCount%9),eatCount%6,192-eatCount%30,12);
            ellipse(x, y, 128+(sizeOffset), 128+(sizeOffset/2));
            
            if (eatCount > 500) {
              disable.play();
            }
            else if (eatCount <= 500) {
              // sound file went here
            }

            // updates the energy of the "killed" cell (host.energy = 0) to "confirmed dead" cell (host.energy = -1)
            // which prevents "killed" logic from running anymore
            host.energy = -1;
          }
        }
      }      
    }
    
    // monitoring Boss eatCount
    println(eatCount);
  }
  
  void display() {
    if (eatCount <= 500) {
      fill(255,0,0,96); 
    }
    else if (eatCount > 500) {
      fill (fed, 96);
    }
    stroke(127, 0, 127);
    ellipseMode(CENTER);
    
    if(stun == true) {
      ellipse(x, y, 128+(sizeOffset/2), 128+(sizeOffset/2));
    }
    else {
      ellipse(x, y, 128+(sizeOffset/2), 128+(sizeOffset/2));
    }
  }
}