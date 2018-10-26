class Branch{
    int _numChildren =3; 
int _maxLevels =8;
int imageCount;

  float level, index;
  float x, y,z;
  float endx, endy,endz;
  
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;
  
  PVector v,p;
  
  Branch[]children = new Branch[0];
  
  Branch(float lev, float ind, float ex, float why,float zen){
    level = lev;
    index = ind;
    v=PVector.random3D();
    p=PVector.random3D();
    
    
    strokeW = (2/level)*2;  //change the stroke weight of the branches
    alph = 255/level;
    len = (1/level)*random(400);  //randomised length properties
    rot = random(60);            //randomised rotation properties
    lenChange = random(10)-5;
    rotChange = random(10)-5;
    v.mult(len);
   
    
    updateMe(ex,why,zen);
    
    if(level< _maxLevels){
      children = new Branch[_numChildren];
      for(int x=0; x< _numChildren; x++){
        children[x] = new Branch(level+1,x,endx,endy,endz);
      }
    }
  
  }
  void updateMe(float ex, float why, float zen){
    x = ex;
    y = why;
    z= zen;
    
    rot += rotChange;
    if(rot > 360) {rot = 0;}
    else if(rot < 0) {rot = 360;}
    
    len -= lenChange;
    if(len < 0) {lenChange *= -1;}
    else if(len >50) { lenChange *= -1;}
    
   float radian = radians(rot-1);
   endx = x+(len * cos(radian));
   endy = y+(len * sin(radian));
   endz = z+(len * sin(radian));
    
    for(int i=0; i<children.length; i++){
      children[i].updateMe(endx,endy,endz);
    }
  }
  
  void drawMe(){
    
    if(level>1){
    pushMatrix();
    fill(100,0,20);
    PVector v2 = new PVector(1,0,1);
    PVector p=v.cross(v2);
    rotate(len,p.x,p.y,p.z);
    stroke(0);
    strokeWeight(strokeW);
    line(0,0,0,v.x,v.y,v.z);
       translate(v.x,v.y,v.z);
     noStroke();
    sphere(len/20);
  
     popMatrix();
    //ellipse(endx, endy, len/random(7,15), len/12);
        //stroke(0,alph);
        //line(x,y,endx,endy);
    }
    for(int i=0; i<children.length; i++){
      children[i].drawMe();
    }
  }
  
}
