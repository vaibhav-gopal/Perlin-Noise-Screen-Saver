class Particle{
  PVector pos = new PVector(random(width),random(height));
  PVector vel = new PVector(0,0);
  PVector accel = new PVector(0,0);
  int buffer = 1;
  float maxVel = 4; //less order
  
  PVector prevPos = pos.copy();
  
  void update(){
    vel.add(accel);
    vel.limit(maxVel);
    pos.add(vel);
    accel.mult(0);
    
    edges();
    show();
    
  }
  
  void follow(PVector[][] field){
    int x = constrain(floor(pos.x / fieldScale), 0, cols-1);
    int y = constrain(floor(pos.y / fieldScale), 0, rows-1);
    applyForce(field[x][y]);
  }
  
  void applyForce(PVector force){
    accel.add(force);
  }
  
  void show(){
    stroke(0, 2.5);
    strokeWeight(1);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
    updatePrev();
  }
  
  void updatePrev(){
    prevPos = pos.copy();
  }
  
  void edges(){
    if (pos.x > width + buffer) {
      pos.x = 0 - buffer;
      updatePrev();
    }
    if (pos.x < 0 - buffer) {
      pos.x = width + buffer;
      updatePrev();
    }
    if (pos.y > height + buffer) {
      pos.y = 0 - buffer;
      updatePrev();
    }
    if (pos.y < 0 - buffer) {
      pos.y = height + buffer;
      updatePrev();
    }
  }
}
