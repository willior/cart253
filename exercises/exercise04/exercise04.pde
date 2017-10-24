// Griddies
// by Pippin Barr
// MODIFIED BY: Will Graham-Simpkins
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element (in pixels; 20x20)
int gridSize = 20;
// An array storing all the griddies
// Griddie[] : a type, tells processing it is an array of ints
// griddies : name of the variable containing the declared array
// = new Griddie[100]: initializing the variable to make a new array
// Griddie is the type of value the array will store
// Griddie[100] : the array can store 100 Griddies
// each instance in the array is known as an element, and they are numbered (indexes)
// 
Griddie[] griddies = new Griddie[100];
Parasite[] parasites = new Parasite[10];
// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // this loop creates 100 Griddie objects
  // i is instantiated at 0; griddies.length = 100;
  // adds 1 to i, thus repeating the process for each element of the array
  // effectively giving a random x/y-pos to each of the 100 Griddie objects
  // which have been created by the loop
  
  // griddies.length : the length of the array, 100
  for (int i = 0; i < griddies.length; i++) {
    
    // floor : rounds down a float to its nearest integer value
    // random : creates random value between 0 and the window size divided by gridSize (20)
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    
    // griddies[i] = new Griddie : creates a new instance of the Griddie class
    // using [i] as the element number in the array
    // its 3 properties being x-pos, y-pos, and size
    // (x/y-pos being factors of the previous random function, and gridSize=20)
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }
  for (int p = 0; p < parasites.length; p++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    
    parasites[p] = new Parasite(x * gridSize, y * gridSize, gridSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time... (using a different value in the for loop, j)
    for (int j = 0; j < griddies.length; j++) {
      
      // QUESTION: What is this if-statement for?
      // this if-statement checks if the value of j is NOT equal to the value of i...
      // AFTER the griddies[i]update() function is run
      // basically, compares each individual griddie with every other one and NOT itself...
      // then runs the collide() function
      if (j != i) {
        
        // QUESTION: What does this line check?
        // this line checks if there are 2 griddies colliding or overlapping...
        // and runs the collide() function if they are...
        // griddies[j] being the "other" griddie referred to in the Griddie class
        // simply put, compares all griddies[i] and griddies[j] values that are NOT identical...
        // ie. aren't the same Griddie object (by comparing their index number)...
        // and runs the collide() function to check if they are overlapping...
        // and runs the code set in the collide() function if they in fact are
        // ie. if either griddie has an energy level of 0 (aka it is "dead")...
        // or if they have identical x&y coordinates (aka if they are overlapping)
        griddies[i].collide(griddies[j]);
      }
    }
    for (int p = 0; i < parasites.length; p++) {
      parasites[p].update();
      for (int j = 0; j < griddies.length; j++) {
        if (j != p) {
          parasites[p].attack(griddies[j]);
        }
      }
    }
      
    
    // Display the griddies
    griddies[i].display();
    parasites[p].display();
    
  }
}