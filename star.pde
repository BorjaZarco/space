class Star {
  String name;
  float ownAngleY;
  float ownSpeed;
  
  PShape star;
  ArrayList<Planet> planets;
    
  public Star(String name, float size, float ownSpeed, String imgSrc) {
    this.name = name;
    this.ownSpeed = ownSpeed;
    this.ownAngleY = random(1, 360);
    
    star = createShape(SPHERE, size);
    PImage img = loadImage(imgSrc); 
    star.setTexture(img);
    
    planets = new ArrayList();
  }
  
  void repaint(){
    pushMatrix();
    rotateY(radians(this.ownAngleY));
    shape(star);
    popMatrix();
    
    this.ownAngleY += this.ownSpeed;
    if (this.ownAngleY > 360) {
      this.ownAngleY = 0;
    }
    
    for(Planet p: planets) {
      p.repaint();
    }
    
  }
  
  boolean addPlanet(Planet planet) {
    return planets.add(planet);
  }
  
}
