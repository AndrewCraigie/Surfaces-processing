// Andrew Craigie
// traingle_strip_surface_fish.pde

// Creating animated and colour changing 'jelly-fish-like' surfaces using traingle strips

Axis axis;

//-----

float camR = 0.0;
float camX = 0.0;
float camY = 0.0;
float camZ = 0.0;

float targetX = 0.0;
float targetY = 0.0;
float targetZ = 0.0;

float camDirX = 0.0;
float camDirY = 1.0;
float camDirZ = 0.0;

float camAlpha = -18.0;    // Angle of camera around x axis
float camBeta = 340;       // Angle of camera around y axis

float camBetaIncrement = 0.1;
float camAlphaIncrement = 0.0;

float easing = 1.2;


boolean wobble = false;

float spacing = 30;

float colIncrement = 0;
float colIncrement2 = 0;

WaveSurface surf1;
WaveSurface surf2;

boolean animatedTimeline = false;
boolean dragged = false;


void setup() {
  size(1280, 720, P3D);

  perspective(PI/3.0, (float)width/height, 1, 100000);

  // Optionally add an XYZ axis indicators
  //axis = new Axis(0.0, 0.0, 0.0, width, height, width, 2);


  // WaveSurface(float areaWidth, float areaDepth, int numCols, int numRows)
  surf1 = new WaveSurface(800, 800, 100, 100);
  surf2 = new WaveSurface(800, 800, 100, 100);
}


void keyPressed() {

  if (keyCode == DOWN) {
    camR += 10;
    println("Camera radius: ", camR);
  }
  if (keyCode == UP) {
    camR -= 10; 
    println("Camera radius: ", camR);
  }

  if (key == 'o' || key == 'O') {
    ortho(-camR/2, camR/2, -camR/2, camR/2); // Same as ortho()
  }

  if (key == 'p' || key == 'P') {
    perspective();
  }

  if (key == 'w' || key == 'W') {
    wobble = !wobble;
    camAlpha = 0;
  }
}

void mouseDragged() {
  dragged = true;
  camAlpha = map(mouseY, 0, height, 180, -180);
  camBeta = map(mouseX, 0, width, -180, 180);
}

void updateCamera() {
  camX = camR * cos(radians(camAlpha)) * cos(radians(camBeta));
  camY = camR * sin(radians(camAlpha));
  camZ = camR * cos(radians(camAlpha)) * sin(radians(camBeta));
}

void draw() {
  colorMode(HSB, 1.0, 1.0, 1.0);
  background(0.0, 0.0, 0.0);

  // Optionally display an X, Y, Z axis
  //pushStyle();
  //colorMode(RGB, 255, 255, 255);
  //axis.draw(color(255, 0, 0), color(0, 255, 0), color(0, 0, 255));
  //popStyle();

  updateCamera();
  camera(camX, camY, camZ, targetX, targetY, targetZ, camDirX, camDirY, camDirZ);

  // Display first surface
  surf1.show(new PVector(0, spacing, 0), 100, colIncrement);


  // Display second surface flipped upside down
  pushMatrix();
  rotateZ(PI);
  surf2.show(new PVector(0, spacing, 0), 100, colIncrement);
  popMatrix();

  colIncrement += 0.03;

  camBeta += camBetaIncrement;

  if (wobble) {
    camAlphaIncrement += 0.1;
    camAlpha += sin(camAlphaIncrement) * 2;
  }

  camAlphaIncrement -= 0.3;


  // Rough code to create animation timeline
  // Remove code below to view the surfaces without camera motion

  // Camera angle can be changed by dragging the mouse on the window

  if (animatedTimeline) {
    if (frameCount > 60 * 15) {

      if (frameCount < 60 * 28) {
        camR += 0.7 * easing;
      }
    } else {
      camR += 0.4;
    }

    if (frameCount == 60 * 20) {
      spacing -= 0.0;
    }

    if (frameCount == 60 * 21) {
      spacing -= 0.45;
    }

    if (frameCount > 60 * 22) {

      if (frameCount > 60 * 32) {
        spacing -= 1.2;
      } else {
        spacing -= 0.9;
      }
    } else {
      spacing += 0.05;
    }
  } else {
    
    if(!dragged){
      camR = 800;
      camAlpha = -30.0;    
    }
    
     
  }

  // ------------ End of camera animation code


  //noLoop();
}
