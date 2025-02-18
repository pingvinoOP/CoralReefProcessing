import java.util.ArrayList;

PGraphics pointerLayer;  
ArrayList<Bubble> bubbles;  
int x, y;     
float step;     

void setup() {
  size(780, 720);
  frameRate(12);
  
  pointerLayer = createGraphics(width, height);
  pointerLayer.beginDraw();
  pointerLayer.background(0, 0);  
  pointerLayer.endDraw();
  
  x = width / 2;
  y = height / 2;
  
  int bubbleCount = (int) random(15, 26);
  bubbles = new ArrayList<Bubble>();
  for (int i = 0; i < bubbleCount; i++) {
    bubbles.add(new Bubble());
  }
}

void draw() {
  backgroundColorSwitchBubbles();
  
  for (Bubble b : bubbles) {
    b.update();
    b.display();
  }
  
  pointerLayer.beginDraw();
  pointerLayer.strokeWeight(8);
  
  float r = random(5);
  step = random(15, 30);
  int colorR = 0, colorG = 0, colorB = 0;
  
  for (int i = 0; i < step; i++) {
    pointerLayer.pushStyle();
    
    if (r < 1) {
      colorR = 0; 
      colorG = (int) random(255); 
      colorB = 150;
      x++;
    } else if (r < 2) {
      colorR = (int) random(255); 
      colorG = 0; 
      colorB = 150;
      x--;
    } else if (r < 3) {
      colorR = (int) random(220, 255); 
      colorG = (int) random(0, 120); 
      colorB = (int) random(50, 120);
      y++;
    } else if (r < 4) {
      colorR = (int) random(0, 100); 
      colorG = (int) random(125, 200); 
      colorB = (int) random(50, 125);
      y--;
    }
    
    pointerLayer.stroke(colorR, colorG, colorB);
    
    pointerLayer.point(x, y);
    pointerLayer.point(width - x, y);
    pointerLayer.point(x, height - y);
    pointerLayer.point(width - x, height - y);
    
    pointerLayer.popStyle();
  }
  pointerLayer.endDraw();
  
  image(pointerLayer, 0, 0);
}

void backgroundColorSwitchBubbles() {
  background(lerpColor(color(1, 87, 155), color(178, 223, 219), sin(frameCount * 0.02) * 0.5 + 0.5));
}

class Bubble {
  float x, y, size, speed, drift;
  
  Bubble() {
    reset();
  }
  
  void update() {
    y += speed;
    x += drift;
    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y > height) {
      reset();
    }
  }
  
  void display() {
    pushStyle();
    fill(225, 245, 254, 80);
    stroke(225, 245, 254, 80);
    circle(x, y, size);
    popStyle();
  }
  
  void reset() {
    x = random(width);
    y = random(-200, 0);  
    size = random(20, 50);
    speed = random(2, 5);
    drift = random(-1.5, 1.5);
  }
}
