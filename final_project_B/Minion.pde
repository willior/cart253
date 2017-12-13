// Minion
//
// a class that defines minion objects, which exist as the ends of the Boss's appendages and instantly kill cells

class Minion {

  int drainEnergy = 255;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 8;
  float x;
  float y;
  
  int count;

  float killCount = 0;
  float sizeOffset;
  int eatCount = 0;

  float killSFXseed;

  boolean stun;

  // minion colours
  color fill = color(0, 0, 255);
  color fed = color(255,0,255);
  color stunned = color(0,255,255);
  float fade = 128;
  
  // variable used to get stunned minions to shake
  int stunOffset = 0;

  Minion(float tempX, float tempY, int tempSize, int tempCount) {
    x = tempX;
    y = tempY;
    size = tempSize;
    count = tempCount;
  }

  void update() {
    
    if (bossApproach > 0){
      return;
    }
 
    if (eatCount > 64) {
      fade -= 0.3;
      y += 0.3;
    }

    else if (stun == false) {

      // created a new variable, sizeOffset, to modulate both the minion hitbox and size based off each minion's kill count
      sizeOffset = killCount/4;
      sizeOffset += eatCount*4;
      
      // minion coordinates
      // added 'count' to the Minion constructor to differentiate each instance of Minion...
      // ... allowing each one to have their own set of XY coordinates
      for(int m=0; m<4; m++){
        x = boss.mx[count];
        y = boss.my[count];
      }
      
    }

    else if (stun == true) {
      
      // changes minion colour while stunned
      fill = stunned;
    }
  }

  // minion attack function
  void attack(Cell host) {
    
    // overrides attack function by returning if "fed"
    if (eatCount > 64) {
      return;
    }

    if (stun == false) {

      // minion hitbox logic
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

            // updates minion kill count
            killCount++;

            // updates the energy of the "killed" cell (host.energy = 0) to "confirmed dead" cell (host.energy = -1)
            // which prevents "killed" logic from running anymore
            host.energy = -1;
          }
        }
      }
    }
    
    // hitbox behaviour while minions stunned
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

            // updates minion eat count
            eatCount++;
            
            // visual feedback for feeding minions (draws a red ellipse on eat frame)
            stroke(255);
            fill(255,0,0,255);
            ellipse(x, y, 20+(sizeOffset), 20+(sizeOffset));
            
            // plays sound effect once disabled
            if (eatCount > 64) {
              disable.play();
            }
            else if (eatCount <= 64) {
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
    if (eatCount <= 64) {
      fill(fill, fade); 
    }
    else if (eatCount > 64) {
      fill(fed, fade);
    }
    stroke(127, 0, 127, fade);
    ellipseMode(CENTER);
    
    // vibrates the minion if stunned:
    // in this logic chain, the first two if statements are for when the stun is almost over...
    // ...vibrating the minion with more intensity as a visual cue for when your stun is running out
    if ((stun == true)&&(stunOffset == 1)&&(eatCount < 64)&&(stunTime<32)) {
      ellipse(x+2, y+1, 40+(sizeOffset), 40+(sizeOffset));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 64)&&(stunTime<32)) {
      ellipse(x-2, y-1, 40+(sizeOffset), 40+(sizeOffset));
      stunOffset++;
    }
    
    // the next two if statements are for the normal stun (vibrates left and right; offset = 1 pixel)
    else if ((stun == true)&&(stunOffset == 1)&&(eatCount < 64)) {
      ellipse(x+1, y, 40+(sizeOffset), 40+(sizeOffset));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 64)) {
      ellipse(x-1, y, 40+(sizeOffset), 40+(sizeOffset));
      stunOffset++;
    }
    
    // if the minion is not stunned, it is drawn normally
    else {
    strokeWeight(0);
    fill((eatCount/2),(255-eatCount/4),0,fade);
    ellipse(x, y, 40+(sizeOffset), 40+(sizeOffset));
    }
  }
}