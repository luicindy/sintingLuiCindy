import peasy.*;
int _numChildren =3; 
int _maxLevels =8;
int imageCount;

import controlP5.*;
ControlP5 gui;
ControlP5 cp5;
float colors;

float speed;

Branch _trunk;
PeasyCam cam;

void setup() {
  size(1000,1000,P3D);
   smooth();
  cam = new PeasyCam(this, 500);
  //cam.setMinimumDistance(500);
  //cam.setMaximumDistance(500);
  //  cam.lookAt(50, 200, 100);
 cam.setRollRotationMode();
 cam.setWheelScale(.1);
  
    newTree();
    
       //gui=new ControlP5(this);
       cp5 = new ControlP5(this);
  
   cp5.addKnob("colors")
  .setPosition(100,40)
  .setSize(120,120)
  .setRange(0,100)
    .setColorBackground(#4c0000)
  .setColorLabel(#cc0000)
  .setColorForeground(#990000)
  .setColorActive(#cc0000)
  .setValue(50);
  
     cp5.addSlider("speed")
  .setPosition(65,40)
  .setSize(18,120)
  .setRange(0.01,10)
  .setColorBackground(#4c0000)
  .setColorLabel(#cc0000)
  .setColorForeground(#990000)
  .setColorActive(#cc0000)
  .setValue(0);
 cp5.setAutoDraw(false);


}
void newTree(){
  _trunk = new Branch(2,0,width,height,width);
  _trunk.drawMe();
}

void draw() {
  //rotateX(-.05);
  //rotateY(-.05);
  background(50,50,50);
  lights();
  pushMatrix();
      _trunk.updateMe(width/3,height/3,width/3);
    _trunk.drawMe();;
 
  popMatrix();
   gui();
}
void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}
  
