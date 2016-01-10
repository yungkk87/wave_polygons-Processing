class Line{
  float a,b;
  Line(){
    
  }
  
  Line(float x1, float x2, float y1, float y2){
    a=(y1-y2)/(x1-x2);
    b=y1-a*x1;
  }

}