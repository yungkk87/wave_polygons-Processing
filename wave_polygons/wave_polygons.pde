import controlP5.*;

int n;
int temp=100;
int r=30;
PVector dot=new PVector(r*tan(PI/n),r);
PVector dots[]=new PVector[1000];
Line lines[]=new Line[1000];
float angle=PI/2*3;
float w=0.01;
ArrayList<PVector> dotsCycle = new ArrayList<PVector>();
float step=0;
boolean line;
PVector tempDot=new PVector();

ControlP5 cp5;

void setup(){
  size(500,150);
  
  cp5 = new ControlP5(this);
  
  //cp5.begin(cp5.addBackground("abc"));
  
  cp5.addSlider("n")
     .setPosition(10, 120)
     .setSize(200, 20)
     .setRange(3, 50)
     .setValue(3)
     ;
  
  //cp5.end();
  rectMode(CENTER);
}

void draw(){
  
  background(125);
  
  if(temp!=n || step>=100*PI){
    background(125);
    dotsCycle.clear();
  dots[0]=new PVector(r*tan(PI/n),r);
  for(int i=1; i<n; i++){
    dot.x=cos(2*PI/n)*dots[i-1].x-sin(2*PI/n)*dots[i-1].y;
    dot.y=sin(2*PI/n)*dots[i-1].x+cos(2*PI/n)*dots[i-1].y;
    dots[i]=dot.copy();
    lines[i-1]=new Line(dots[i-1].x,dots[i].x,dots[i-1].y,dots[i].y);
  }
    lines[n-1]=new Line(dots[0].x,dots[n-1].x,dots[0].y,dots[n-1].y);
    temp=n;  
    step=0;
    angle=PI/2*3;
  }
  
  pushMatrix();
  //background(125);
  translate(2*r,2*r+20);
  beginShape();
  for(int i=0; i<n; i++){
    vertex(dots[i].x,dots[i].y);
  }
  vertex(dots[0].x,dots[0].y);
  endShape();
  
  if(angle<=0)
    angle+=2*PI;
  for(int i=1; i<n; i++){
    if(PI/n*(2*i-1)<=angle && PI/n*(2*i-1)+2*PI/n>angle){
      tempDot.x=lines[i].b/(tan(angle-PI/2)-lines[i].a);
      tempDot.y=lines[i].a*lines[i].b/(tan(angle-PI/2)-lines[i].a)+lines[i].b;
      break;
    }
  }
  if(angle>=2*PI-PI/n || angle<PI/n){
    tempDot.x=lines[0].b/(tan(angle-PI/2)-lines[0].a);
    tempDot.y=lines[0].a*lines[0].b/(tan(angle-PI/2)-lines[0].a)+lines[0].b;
  }
  else if(n%4==0 && abs(angle-PI/2*3)<=PI/n){
    tempDot.x=r;
    tempDot.y=r*tan(angle-PI/2*3);
  }
  else if(n%4==0 && abs(angle-PI/2)<=PI/n){
    tempDot.x=-r;
    tempDot.y=-r*tan(angle-PI/2);
  }

  dotsCycle.add(new PVector(tempDot.x,tempDot.y));
  
  for(int i=0; i<dotsCycle.size(); i++){
    ellipse(r+i*0.5,dotsCycle.get(i).y,1,1);
  }
  line(0,0,tempDot.x,tempDot.y);
  line(tempDot.x,tempDot.y,r+step,tempDot.y);
  rect(tempDot.x,tempDot.y,5,5);
  rect(r+step,tempDot.y,5,5);
  
  step+=0.5;
  angle-=w;
  popMatrix();
}