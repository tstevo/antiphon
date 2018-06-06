int count;
Dot[] dots;
float spread;

void setup() {
  size(1000, 600);
  background(42,36,48);
  noStroke();
  count = 600;
  spread = 250;
  dots = new Dot[count];

  for (int y = 0; y < count; y++) {
    boolean connTemp = false;
    if(random(1)<0.12){
      connTemp = true;
    } 
    dots[y] = new Dot(random(0,spread), radians(random(0,360)), int(random(6,16)), int(random(100,255)), connTemp,0,0);
  }
}

void draw() {
  background(42,36,48);
    for (Dot dot : dots) {
      dot.connect();
      pushMatrix();
        translate(width/2,height/2);
        dot.display();
      popMatrix();
    }
  noLoop();
}


class Dot {
  float radius, ang, dSize, absX, absY;
  int fade;
  boolean conn;
  
  // Contructor //radius, angle, size, colour, fade //connector = red dot?
  Dot(float radiusT, float angT, float dSizeT, int fadeT, boolean connT, float absXT, float absYT) {
    radius = radiusT;
    ang = angT;
    dSize = dSizeT;
    fade = fadeT;
    conn = connT;
    absX = absXT;
    absY = absYT;
  }
  
  // method for updating the variables
  void update() {
  }
  
  // method for finding closest dots
  void connect(){
    absX = screenX(radius*cos(ang),radius*sin(ang));
    absY = screenY(radius*cos(ang),radius*sin(ang));
    if(conn){
      for (Dot dot2 : dots) {
        if(dist(absX,absY,dot2.absX,dot2.absY)<20){
          stroke(255);
          line(absX,absY,dot2.absX,dot2.absY); 
        }
      }
    }
  }
  
  // method for drawing the object
  void display() {
    color cor;
    if(conn){
     cor = color(186,4,77);
    } else {
     cor = color(237,212,109); 
    }
    fill(cor,fade);
    pushMatrix();
      noStroke();
      translate(radius*cos(ang),radius*sin(ang));
      ellipse(0, 0, dSize/2, dSize/2);
    popMatrix();
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("antiphon"+(System.currentTimeMillis()/1000)+".png");
    print("saved.");
  }
}