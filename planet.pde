class Planet {
  String name;
  
  float offsetX;
  
  float ownAngleY;
  float ownSpeed;
  
  float orbitAngle;
  float orbitSpeed;
  float orbitInclination;
  
  PShape planet;
  ArrayList<Satellite> satellites;
  
  public Planet(String name, float size, float ownSpeed, float offsetX, float orbitSpeed, String imgSrc) {
    this.name = name;
    
    this.offsetX = offsetX;
    
    this.ownSpeed = ownSpeed;
    this.ownAngleY = random(1, 360);
    
    this.orbitAngle = random(1, 360);
    this.orbitInclination = random(1, 45);
    this.orbitSpeed = orbitSpeed;
    
    
    planet = createShape(SPHERE, size);
    PImage img = loadImage(imgSrc); 
    planet.setTexture(img);

    satellites = new ArrayList();
  }
  
  void repaint(){
    pushMatrix();
    rotateZ(radians(this.orbitInclination));
    rotateY(radians(this.orbitAngle));
    translate(this.offsetX, 0, 0);
    rotateY(radians(this.ownAngleY));
    translate(0, 0, 0);
    shape(planet);
    popMatrix();
    
    
    
    this.ownAngleY += this.ownSpeed;
    if (this.ownAngleY > 360) {
      this.ownAngleY = 0;
    }
    
    this.orbitAngle += this.orbitSpeed;
    if (this.orbitAngle > 360) {
      this.orbitAngle = 0;
    }
    
    for(Satellite s: satellites) {
      s.repaint();
    }
    
  }
  
  boolean addSatellite(Satellite satellite) {
    return satellites.add(satellite);
  }
  
}
