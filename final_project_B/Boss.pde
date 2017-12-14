// Boss
//
// a class that defines the boss that appears when all parasites have been disabled
class Boss {

  int drainEnergy = 192;
  int size;
  int energy;

  float tx = random(0, 100);
  float ty = random(0, 100);

  float speed = 8;
  int x;
  int y;
  
  float[] mx = new float[8];
  float[] my = new float[8];

  float killCount = 0;
  float sizeOffset;
  int eatCount = 0;
  int mEatCount;

  float killSFXseed;
  
  float tailMod;

  boolean stun;
  
  int stunOffset = 0;

  color fill = color(0, 0, 255);
  color fed = color(255,0,255);
  float fade = 128;
  float death = 127;

  Boss(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
  }
  
  void update() {
    
    // boss's main body increases in size as minions absorb cells
    mEatCount = minions[0].eatCount + minions[1].eatCount + minions[2].eatCount + minions[3].eatCount;
    
    if ((bossApproach > 0) || (disableCount < 10)) {
      return;
    }
    
    // tracking the boss's health
    energy = 512;
    if (severCount == 8) {
      energy = energy - eatCount;
    }
    
    // boss fades once dead
    if (energy <= 0) {
      
      fade -= 0.4;
      
    }

    else if (stun == false) {

      // created a new variable, sizeOffset, to modulate both the parasite hitbox and size based off each parasite's kill count
      sizeOffset = killCount/4;
      sizeOffset += eatCount/2;
      sizeOffset += mEatCount/4;

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
      
      sizeOffset = killCount/4;
      sizeOffset += eatCount/2;
      sizeOffset += mEatCount/4;

    }
  }

  // boss attack function
  void attack(Cell host) {
    
    // overrides attack function by returning if "fed"
    if (energy <= 0) {
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

          host.energy = constrain(host.energy, 0, 255);

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
    
    // hitbox behaviour while boss stunned & all 4 minions severed
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

          host.energy = constrain(host.energy, 0, 255);

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
            println(energy);
            
            // visual feedback
            if (severCount < 8) {
              stroke(255);
            }
            else {
              stroke(0);
            }
            
            // fill(255-(eatCount%8),127-eatCount%16,eatCount%4,12);
            
            fill(255,255,255,fade);
            ellipse(x, y, 80+(sizeOffset/2), 80+(sizeOffset/2));
            
            // fill(255-(eatCount%32),eatCount%8,192-eatCount%64,12);
            
            if (energy <= 0) {
              disable.play();
            }
            else if (energy > 0) {
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
    // println(eatCount);
  }
  
  void display() {
    if (energy > 0) {
      
      // boss tails
      if (stun == false) {
      tailMod = frameCount / (64.0+energy/2);
      }
      else if ((stun == true)&&(severCount == 8)) {
      tailMod = frameCount / ((energy*4) / (64.0+eatCount*4));

      }
      for (int i = 0; i < 8; i++) {
        strokeWeight(5);
        stroke((255-energy/2),(energy/4),(energy/12),fade*1.5);
        fill(255,0);
        int bx = x;
        int by = y;
        
        // 8 sets starting anchor coordinates, each offset to create a small circular (octagonal) shape
        if (i == 0){
          bx = x; by = y-8;
        }
        if (i == 1){
          bx = x+6; by = y-6;
        }
        if (i == 2){
          bx = x+8; by = y;
        }
        if (i == 3){
          bx = x+6; by = y+6;
        }
        if (i == 4){
          bx = x; by = y+8;
        }
        if (i == 5){
          bx = x-6; by = y-6;
        }
        if (i == 6){
          bx = x-8; by = y;
        }
        if (i == 7){
          bx = x-6; by = y-6;
        }
        
        
        // mx & my (m for minion) are variables used to define both the ending anchor of the Boss's appendages...
        // ... and for the coordinates of the Minion objects
        mx[i] = noise(3, i*4, tailMod)*width;
        my[i] = noise(5, i*4, tailMod)*height;
        
        bezier(
        // starting anchor coordinates
        
        bx,by,
        // control points for curves:
        // 1 (x, y)
        noise(0, i*4, tailMod)*width, noise(1, i*4, tailMod)*height, 
        // 2 (x, y)
        noise(2, i*4, tailMod)*width, noise(4, i*4, tailMod)*height, 
        
        // ending anchor coordinates
        mx[i], my[i]);
      } 
    }
    else if (energy <= 0) {
      
      // death = death+sizeOffset/2;
      
      fill (224+death, 128+(-fade), 128+(-fade), 32+fade);
      fade -= 0.12;
      
      strokeWeight(16);
    stroke(127, 127, 127, fade);
    ellipseMode(CENTER);
    ellipse(x,y,death+sizeOffset/2,death+sizeOffset/2);
    death += 0.64;
    
    return; 
    
    }
    strokeWeight(1);
    stroke(127, 127, 127, fade);
    ellipseMode(CENTER);
    
    if((stun == true)&&(severCount == 8)) {
      fill(255,255,0,fade);
      // ellipse(x, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
    }
    
    // vibrates the boss if stunned:
    // in this logic chain, the first two if statements are for when the stun is almost over...
    // ...vibrating the boss with more intensity as a visual cue for when your stun is running out
    if ((stun == true)&&(stunOffset == 1)&&(eatCount < 128)&&(stunTime<32)) {
      ellipse(x+3, y+2, 160+(sizeOffset/2), 160+(sizeOffset/2));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 128)&&(stunTime<32)) {
      ellipse(x-3, y-2, 160+(sizeOffset/2), 160+(sizeOffset/2));
      stunOffset++;
    }
    
    // the next two if statements are for the normal stun (vibrates left and right; offset = 1 pixel)
    else if ((stun == true)&&(stunOffset == 1)&&(eatCount < 128)) {
      ellipse(x+2, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
      stunOffset--;
    }
    else if ((stun == true)&&(stunOffset == 0)&&(eatCount < 128)) {
      ellipse(x-2, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
      stunOffset++;
    }

    else {
      fill((255-energy/2),(energy/4),(energy/12),fade*1.2);
      ellipse(x, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
    }
  }
}