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
  
  float[] mx = new float[4];
  float[] my = new float[4];

  float killCount = 0;
  float sizeOffset;
  int eatCount = 0;
  int mEatCount;

  float killSFXseed;
  
  float tailMod;

  boolean stun;

  color fill = color(0, 0, 255);
  color fed = color(255,0,255);
  float fade = 128;

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
    if (severCount == 4) {
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
            println(eatCount);
            
            // visual feedback
            if (severCount < 4) {
              stroke(255);
            }
            else {
              stroke(0);
            }
            
            fill(255-(eatCount%8),127-eatCount%16,eatCount%4,12);
            ellipse(x, y, 128+(sizeOffset/2), 128+(sizeOffset));
            fill(255-(eatCount%32),eatCount%8,192-eatCount%64,12);
            ellipse(x, y, 128+(sizeOffset), 128+(sizeOffset/2));
            
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
      tailMod = frameCount / (64.0+eatCount*2);
      }
      else {
      //  tailMod = frameCount / (64.0+eatCount*2);

      }
      for (int i = 0; i < 4; i++) {
        strokeWeight(4);
        stroke((eatCount/2),(255-eatCount/4),0,127);
        fill(255,0);
        int bx = x;
        int by = y;
        
        // starting anchor coordinates
        if (i == 0){
          bx = x-5; by = y-5;
        }
        if (i == 1){
          bx = x+5; by = y-5;
        }
        if (i == 2){
          bx = x-5; by = y+5;
        }
        if (i == 3){
          bx = x+5; by = y+5;
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
      fill (fed, fade);
    }
    strokeWeight(1);
    stroke(127, 127, 127);
    ellipseMode(CENTER);
    
    
    if((stun == true)&&(severCount == 4)) {
      fill(eatCount/2,127,0,fade);
      ellipse(x, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
    }
    else {
      fill((eatCount/2),(255-eatCount/2),0,fade);
      ellipse(x, y, 160+(sizeOffset/2), 160+(sizeOffset/2));
    }
  }
}