// If you press button 'd' you can draw shape.
// Click your mouse to make new point of polygons.
// If you finish to draw, press button 'd' one more.

int n=0;
float temp;
PVector dot;
PVector center = new PVector(75,75);
Line mainLine;
float angle=0;
float w=0.01;
ArrayList<PVector> dotsCycle = new ArrayList<PVector>();
ArrayList<PVector> dots = new ArrayList<PVector>();
ArrayList<Line> lines = new ArrayList<Line>();
float step=0;
PVector tempDot=new PVector();
PVector tempDot2=new PVector();
boolean clear=false;
boolean draw=false;

void setup(){
  size(500,150);
  rectMode(CENTER);
}

void draw(){
  
  background(255);
  line(150,0,150,150);
  
  if(step>=100*PI || clear){
    background(255);
    step=0;
    angle=0;
    dotsCycle.clear();
    clear=false;
  }
  
  if(draw){
    for(int i=0; i<dots.size(); i++){
      ellipse(dots.get(i).x,dots.get(i).y,5,5);
    }
  }
  
  if(dots.size()>0 && !draw){
    beginShape();
    for(int i=0; i<dots.size(); i++){
      vertex(dots.get(i).x,dots.get(i).y);
    }
    vertex(dots.get(0).x,dots.get(0).y);
    endShape();
    
    if(lines.size()==0){
      for(int i=0; i<dots.size()-1; i++){
        lines.add(new Line(dots.get(i),dots.get(i+1)));
      }
      lines.add(new Line(dots.get(dots.size()-1),dots.get(0)));
    }
    
    mainLine=new Line(center, new PVector(200*cos(angle)+75,200*sin(angle)+75));
    tempDot=new PVector(1000,1000);
    for(int i=0; i<lines.size(); i++){
      if(intersection(mainLine,lines.get(i))){
        temp=(mainLine.b-lines.get(i).b)/(lines.get(i).a-mainLine.a);
        tempDot2=new PVector(temp,temp*mainLine.a+mainLine.b);
        if(center.dist(tempDot)>center.dist(tempDot2))
          tempDot=tempDot2.copy();
      }
    }
    mainLine=new Line(center,tempDot);
    mainLine.display();
    rect(tempDot.x,tempDot.y,5,5);
    
    line(tempDot.x,tempDot.y,150+step,tempDot.y);
    rect(150+step,tempDot.y,5,5);
    dotsCycle.add(new PVector(150+step,tempDot.y));
  
    for(int i=0; i<dotsCycle.size()-1; i++){
      line(dotsCycle.get(i).x,dotsCycle.get(i).y,dotsCycle.get(i+1).x,dotsCycle.get(i+1).y);
    }
    
    step+=0.5;
    angle-=w;
  }
  
  if(angle<=0)
    angle+=2*PI;
  ellipse(75,75,5,5);
}

void keyPressed(){
  if(key==' '){
      clear=true;
      println("space");
      dots.clear();
      lines.clear();
   }
   else if(key=='d'){
     draw=!draw;
     println("d");
   }
}

void mousePressed(){
  if(draw){
    dot=new PVector(mouseX,mouseY);
    dots.add(dot);
  }
}