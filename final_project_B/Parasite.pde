// Parasite
//
// a class that defines parasite objects, which drain energy from cells and become larger when they kill one

class Parasite {

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

  // parasite colours
  color fill;
  color fed = color(255,0,255);
  color stunned = color(0,255,255);
  
  // variable used to get stunned parasites to shake
  int stunOffset = 0;

  Parasite(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }

  void update() {
    
    if (bossApproach > 0){
      return;
    }
    
    // sets default parasite colour (blue)
    fill = color(0, 0, 255);
    
    if (eatCount > 50) {
      
      
      
    }

    else if (stun == false) {

      // created a new variable, sizeOffset, to modulate both the parasite hitbox and size based off each parasite's kill count
      sizeOffset = killCount/4;
      sizeOffset += eatCount*4;

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
      
      // changes parasite colour while stunned
      fill = stunned;
      
    }
  }

  // parasite attack function
  void attack(Cell host) {
    
    // overrides attack function by returning if "fed"
    if (eatCount > 50) {
      return;
    }

    if (stun == false) {

      // parasite hitbox logic
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

            // updates parasite kill count
            killCount++;

            // updates the energy of the "killed" cell (host.energy = 0) to "confirmed dead" cell (host.energy = -1)
            // which prevents "killed" logic from running anymore
            host.energy = -1;
          }
        }
      }
    }
    
    // hitbox behaviour while parasites stunned
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

            // updates parasite eat count
            eatCount++;
            
            // visual feedback for feeding parasites (draws a red ellipse on eat frame)
            stroke(255);
            fill(255,0,0,255);
            ellipse(x, y, 20+(sizeOffset), 20+(sizeOffset));
            
            // plays sound effect once disabled
            if (eatCount > 50) {
              disable.play();
            }
            else if (eatCount <= 50) {
              // sound file went here
            }

            // updates the energy of the "killed" cell (host.energy = 0) to "confirmed dead" cell (host.energy = -1)
            // which prevents "killed" logic from running anymore
            host.energy = -1;
          }
        }
      }      
    }
  }

  void display() {
    if (eatCount <= 50) {
      fill(fill, 96); 
    }
    else if (eatCount > 50) {
      fill (fed, 96);
    }
    stroke(127, 0, 127);
    ellipseMode(CENTER);
    
    // vibrates the parasite if stunned:
    // in this logic chain, the first two if statements are for when the stun is almost over...
    // ...vibrating the parasite with more intensity as a visual cue for when your stun is running out
    if ((stun == true)&&(stunOffset == 1)&&(eatCount < 50)&&(stunTime<32)) {
      ellipse(x+2, y+1, 20+(sizeOffset), 20+(sizeOffset));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 50)&&(stunTime<32)) {
      ellipse(x-2, y-1, 20+(sizeOffset), 20+(sizeOffset));
      stunOffset++;
    }
    
    // the next two if statements are for the normal stun (vibrates left and right; offset = 1 pixel)
    else if ((stun == true)&&(stunOffset == 1)&&(eatCount < 50)) {
      ellipse(x+1, y, 20+(sizeOffset), 20+(sizeOffset));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 50)) {
      ellipse(x-1, y, 20+(sizeOffset), 20+(sizeOffset));
      stunOffset++;
    }
    
    // if the parasite is not stunned, it is drawn normally
    else {
    ellipse(x, y, 20+(sizeOffset), 20+(sizeOffset));
    }
  }
}