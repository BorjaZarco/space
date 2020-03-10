class Spaceship {
  float dirX;
  float dirY;
  float dirZ;
  
  PVector bodyPos;
  PVector targetPos;
  PVector upPos;
  
  float yaw = 0;
  float pitch = 0;
  
  public Spaceship() {
     this.dirX = 0;
     this.dirY = 0;
     this.dirZ = 0;
     bodyPos = new PVector(0.1, 0.1, 0.1);
     targetPos = new PVector(0.1, 0.1, -1);
     upPos = new PVector(0, 1, 0);
  }
  
  public void repaint() { 
    updatePos();
    stroke(1);
    camera(bodyPos.x, bodyPos.y, bodyPos.z, bodyPos.x + targetPos.x, bodyPos.y + targetPos.y, bodyPos.z + targetPos.z, upPos.x, upPos.y, upPos.z);
  }
  
  public void updateEye(float newEyeX, float newEyeY) {
    if (newEyeX == 0 && newEyeY == 0) { return; }
    yaw += newEyeX * 0.1;
    pitch += newEyeY * 0.1;
    
    targetPos.x = cos(radians(yaw)) * cos(radians(pitch));
    targetPos.y = sin(radians(pitch));
    targetPos.z = sin(radians(yaw)) * cos(radians(pitch));
    targetPos.normalize();
    print(targetPos, "\n");    
  }
  
  private void updatePos() {
    if (dirX != 0) {
      bodyPos.add(PVector.mult(targetPos.cross(upPos), 10 * dirX));
    }
    if (dirY != 0) {
      bodyPos.add(PVector.mult(upPos, 10 * dirY));
    }
    if (dirZ != 0) {
      bodyPos.add(PVector.mult(targetPos, 10 * dirZ));
    }
  }
}
