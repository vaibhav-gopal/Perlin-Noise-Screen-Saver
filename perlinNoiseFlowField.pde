float noiseIncrements = 0.05; //complexity ; 'noise zoom level' ; how much noise to use
int chaos = 1; //post-randomness, adds a bit of chaos ; decreases smoothness
float rateOfChange = 0.001; //difference between previous and next noise ; z-dimension change , like time ; how fast to move between noise values
float flowStrength = 0.5; //how much force vectors add ; more order

int fieldScale = 20; //another zoom level of sorts
int cols, rows;

float zOff = 0;

ArrayList<Particle> particles = new ArrayList<Particle>();

PVector[][] flowField;

void setup(){
  size(1200,600, P2D);
  background(255);
  pixelDensity(2);
  blendMode(BLEND);
  cols = floor(width / fieldScale);
  rows = floor(height / fieldScale);
  
  for (int i = 0; i < 800; i++){
    particles.add(new Particle());
  }
  
  flowField = new PVector[cols][rows];
}

void draw(){
  float yOff = 0;
  for (int y = 0; y < rows; y++){
    float xOff = 0;
    for (int x = 0; x < cols; x++){
      float angle = map(noise(xOff, yOff, zOff), 0,1,0,TWO_PI) * chaos;
      
      PVector vect = PVector.fromAngle(angle).setMag(flowStrength);
      flowField[x][y] = vect;
      
      xOff += noiseIncrements;
    }
    yOff += noiseIncrements;
  }
  zOff += rateOfChange;
  
  for (Particle p : particles){
    p.update();
    p.follow(flowField);
  }
}
