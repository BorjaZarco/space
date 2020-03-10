// import gifAnimation.*;
// GifMaker gifFile;

import processing.sound.*;

PFont font;
PImage backgroundImage;
SoundFile sound;

Star sun;
Spaceship spaceship;
int mode = 1;

void setup() {
    size(1024, 1024, P3D);
    sound = new SoundFile(this, "./data/star-wars.mp3");
    sound.amp(0.05);
    backgroundImage = loadImage("./data/stars.jpg");
    //font = loadFont("Roboto-Regular-48.vlw");
    noStroke();
    textSize(32);
    
    spaceship = new Spaceship();
    
    sun = new Star("Sun", 100, 1, "./data/sun.jpg"); 
    sun.addPlanet(new Planet("Mercury", 30, 1, 200, 0.12, "./data/mercury.jpg"));
    sun.addPlanet(new Planet("Venus", 40, 0.66, 300, 0.32, "./data/venus.jpg"));
    Planet earth = new Planet("Earth", 50, 0.005, 500, 0.53, "./data/earth.jpg");
    Planet mars = new Planet("Mars", 50, 0.005, 750, 1, "./data/mars.jpg");
    sun.addPlanet(earth); 
    sun.addPlanet(mars);
    
    earth.addSatellite(new Satellite(earth, "Moon", 10, 0.16, 100, 0.039, "./data/moon.jpg"));
    mars.addSatellite(new Satellite(mars, "Moon1", 10, 0.16, 100, 0.2, "./data/moon.jpg"));
    mars.addSatellite(new Satellite(mars, "Moon2", 10, 0.16, 150, 0.59, "./data/moon.jpg"));
    
    // gifFile = new GifMaker(this, "./assets/space-animation.gif");
    // gifFile.setRepeat(0);
    
   
}

void draw() {
    // gifFile.addFrame();
    if (mode == 0) {
      background(backgroundImage);
      fill(250, 250, 0);
      textAlign(CENTER);
      pushMatrix();
      rotateX(PI/10);
      text("Instructions", width/2, 50);
      text("Hold SPACE to switch display a general view", width/2, 150);
      text("Press I to toggle Instructions", width/2, 250);
      
      text("Click + Drag the mouse to move the view", width/2, 450);
      text("Press W to move forward", width/2, 550);
      text("Press S to move backward", width/2, 650);
      text("Press A to move to the left", width/2, 750);
      text("Press D to move to the right", width/2, 850);
      popMatrix();
      
      stroke(250, 250, 0);
      line(100, 65, width - 100, 65);
      
    } else if(mode == 1) {
      background(backgroundImage); 
      pushMatrix();
     
      
      translate(width/2, height/2, 0);
      scale(0.5);
      
      spaceship.repaint();
      sun.repaint();
      
      
      
      popMatrix();
      
      hint(DISABLE_DEPTH_TEST);
      noLights();
      textMode(MODEL);
      fill(255);
      textAlign(LEFT);
      text("The Solar System", 20, height - 50);
      text("SPACE - general view", 20, 100);
      text("[I] - Instructions", 20, 50);
      hint(ENABLE_DEPTH_TEST);

    } else if (mode == 2) {
      background(backgroundImage); 
      pushMatrix();
     
      camera();
      translate(width/2, height/2, 0);
      scale(0.5);
      sun.repaint();
      
      
      
      popMatrix();
      
      hint(DISABLE_DEPTH_TEST);
      noLights();
      textMode(MODEL);
      fill(255);
      textAlign(LEFT);
      text("The Solar System", 20, height - 50);
      text("SPACE - general view", 20, 100);
      text("[I] - Instructions", 20, 50);
      hint(ENABLE_DEPTH_TEST);

    }
    
    
}

void keyPressed() { 
  if (mode == 1 && (key == 'W' | key == 'w')) {
    spaceship.dirZ = 1;
  }
  if (mode == 1 && (key == 'S' | key == 's')) {
    spaceship.dirZ = - 1;
  }
  if (mode == 1 && (key == 'D' | key == 'd')) {
    spaceship.dirX = 1;
  }
  if (mode == 1 && (key == 'A' | key == 'a')) {
    spaceship.dirX = - 1;
  }
  if (key == ' ') {
    mode = (mode == 1) ? 2 : mode;
  }
  if (mode == 1 && (keyCode == UP)) {
    spaceship.dirY = -1;
  }
  if (mode == 1 && (keyCode == DOWN)) {
    spaceship.dirY = 1;
  }
  
}

void keyReleased() {
  if (key == 'W' | key == 'w' || key == 'S' | key == 's') {
    spaceship.dirZ = (spaceship.dirZ == 1) ? 0 : spaceship.dirZ;
  } 
  if (key == 'S' | key == 's') {
    spaceship.dirZ = (spaceship.dirZ == -1) ? 0 : spaceship.dirZ;
  }
  if (key == 'D' | key == 'd' || key == 'A' | key == 'a') {
    spaceship.dirX = (spaceship.dirX == 1) ? 0 : spaceship.dirX;
  }
  if (key == 'A' | key == 'a') {
    spaceship.dirX = (spaceship.dirX == -1) ? 0 : spaceship.dirX;
  }
  if ((keyCode == UP)) {
    spaceship.dirY = (spaceship.dirY == -1) ? 0 : spaceship.dirY;
  }
  if ((keyCode == DOWN)) {
    spaceship.dirY = (spaceship.dirY == 1) ? 0 : spaceship.dirY;
  }
  if (key == 'I' || key == 'i') {
    mode = (mode == 0) ? 1 : 0;
    if (mode == 0) {
      sound.play();
    } else {
      sound.stop();
    }
  }
  
  if (key == ' ') {
    mode = (mode == 2) ? 1 : mode;
  }
}

void mouseMoved() {
}

void mouseClicked() {
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseDragged() {
  
  spaceship.updateEye(-(pmouseX - mouseX), -(pmouseY - mouseY));
}

void mouseWheel(MouseEvent event) {
}
