int _numChildren =3; 
int _maxLevels =8;
int imageCount;

import controlP5.*;
ControlP5 gui;
float colors;
float zoom;
float speed;


Branch _trunk;

void setup(){
  //size(1000,1000);   //alter the size of the canvas
  //background(0); //change the background colour
  fullScreen();
  noFill();
  smooth();
  newTree();
  scale(600/72.0);

   
   gui=new ControlP5(this);
  
   gui.addKnob("colors")
  .setPosition(100,40)
  .setSize(120,120)
  .setRange(0,100)
    .setColorBackground(#4c0000)
  .setColorLabel(#cc0000)
  .setColorForeground(#990000)
  .setColorActive(#cc0000)
  .setValue(50);

 
   gui.addSlider("zoom")
  .setPosition(30,40)
  .setSize(18,120)
  .setRange(0.01,3)
  .setColorBackground(#4c0000)
  .setColorLabel(#cc0000)
  .setColorForeground(#990000)
  .setColorActive(#cc0000)
  .setValue(0.5)
  .setSliderMode(Slider.FLEXIBLE);
  
     gui.addSlider("speed")
  .setPosition(65,40)
  .setSize(18,120)
  .setRange(0.01,10)
  .setColorBackground(#4c0000)
  .setColorLabel(#cc0000)
  .setColorForeground(#990000)
  .setColorActive(#cc0000)
  .setValue(0);
 


}

void newTree(){
  _trunk = new Branch(1,0,width/2,height/2);
  _trunk.drawMe();
}

  void draw(){
    background(50,50,50);
    _trunk.updateMe(width/2,height/2);
    _trunk.drawMe();
  }

class Branch{
  float level, index;
  float x, y;
  float endx, endy;
  
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;
  

  
  Branch[]children = new Branch[0];
  
  Branch(float lev, float ind, float ex, float why){
    level = lev;
    index = ind;
    
    strokeW = (2/level)*10;  //change the stroke weight of the branches
    alph = 255/level;
    len = (1/level)*random(400);  //randomised length properties
    rot = random(60);            //randomised rotation properties
    lenChange = random(10)-5;
    rotChange = random(10)-5;
    
    updateMe(ex,why);
    
    if(level< _maxLevels){
      children = new Branch[_numChildren];
      for(int x=0; x< _numChildren; x++){
        children[x] = new Branch(level+1,x,endx,endy);
      }
    }
  }
  
  void updateMe(float ex, float why){
    x = ex;
    y = why;
    
    rot += rotChange;
    if(rot > 360) {rot = 0;}
    else if(rot < 0) {rot = 360;}
    
    len -= lenChange;
    if(len < 0) {lenChange *= -1;}
    else if(len >80) { lenChange *= -1;}
    
   float radian = radians(rot);
   endx = x+(len *zoom * cos(radian));
   endy = y+(len *zoom * sin(radian));
    
    for(int i=0; i<children.length; i++){
      children[i].updateMe(endx,endy);
    }
  }
  
  void drawMe(){
    
    if(level>1){
    
    strokeWeight(strokeW);
    stroke(0,alph);
    fill(100*colors,0,20,3*colors);
    line(x,y,endx,endy);
    ellipse(endx, endy, len/random(7,15), len/12);
    }
    for(int i=0; i<children.length; i++){
      children[i].drawMe();
    }
  }
  
  }
  
  void keyPressed(){
  imageCount ++;
  
  if(key==' ') {
    save("/Users/cindylui/Desktop/RMIT/Year 2/conputational prototyping/assignment 2&3/presentation and reprt/  "+("print"+imageCount+".png"));
  }
  }
