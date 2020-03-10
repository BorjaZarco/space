class Satellite {
  Planet planet;
  String name;
  
  float offsetX;
  
  float ownAngleY;
  float ownSpeed;
  
  float orbitAngle;
  float orbitSpeed;
  float orbitDistance;
  float orbitInclination;
  
  PShape satellite;
  
  public Satellite(Planet planet, String name, float size, float ownSpeed, float orbitDistance, float orbitSpeed, String imgSrc) {
    this.planet = planet;
    this.name = name;
    
    this.ownSpeed = ownSpeed;
    this.ownAngleY = random(1, 360);
    
    this.orbitAngle = random(1, 360);
    this.orbitInclination = random(1, 4) * 90;
    this.orbitSpeed = orbitSpeed;
    this.orbitDistance = orbitDistance;
    
    
    satellite = createShape(SPHERE, size);
    PImage img = loadImage(imgSrc); 
    satellite.setTexture(img);
  }
  
  void repaint(){
    pushMatrix();
    rotateZ(radians(planet.orbitInclination));
    rotateY(radians(planet.orbitAngle));
    
    translate(planet.offsetX, 0, 0);
    rotateZ(radians(this.orbitInclination));
    rotateY(radians(this.orbitAngle));
    translate(this.orbitDistance, 0, 0);
    
    rotateY(this.ownAngleY);
    shape(satellite);
    popMatrix();
    
    this.ownAngleY += this.ownSpeed;
    if (this.ownAngleY > 360) {
      this.ownAngleY = 0;
    }
    
    this.orbitAngle += this.orbitSpeed;
    if (this.orbitAngle > 360) {
      this.orbitAngle = 0;
    }
    
    
  }
  
}
