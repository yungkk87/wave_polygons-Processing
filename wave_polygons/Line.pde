class Line{
  float a,b;
  PVector dot1, dot2;
  
  Line(){
  }
  
  Line(PVector m, PVector n){
    a=(m.y-n.y)/(m.x-n.x);
    b=m.y-a*m.x;
    dot1=m.copy();
    dot2=n.copy();
  }
  
  void display(){
    line(dot1.x,dot1.y,dot2.x,dot2.y);
  }
}

int direction(PVector A, PVector B, PVector C){
  float dxAB, dxAC, dyAB, dyAC;
  int dir=0;
  dxAB=B.x-A.x;
  dyAB=B.y-A.y;
  dxAC=C.x-A.x;
  dyAC=C.y-A.y;
  if(dxAB*dyAC<dyAB*dxAC) dir=1;
  if(dxAB*dyAC>dyAB*dxAC) dir=-1;
   if(dxAB*dyAC==dyAB*dxAC){
     if(dxAB==0 && dyAB==0) dir=0;
     else if((dxAB*dxAC<0)||(dyAB*dyAC<0)) dir=-1;
     else if(dxAB*dxAB+dyAB*dyAB>=dxAC*dxAC+dyAC*dyAC) dir=0;
     else dir=1;
   }
   return dir;
}

boolean intersection(Line AB, Line CD){
  boolean LineCrossing=false;
  if((direction(AB.dot1, AB.dot2, CD.dot1)*direction(AB.dot1, AB.dot2, CD.dot2)<=0) && (direction(CD.dot1, CD.dot2, AB.dot1)*direction(CD.dot1, CD.dot2, AB.dot2)<=0))
    LineCrossing=true;
   else
     LineCrossing=false;
   return LineCrossing;
}