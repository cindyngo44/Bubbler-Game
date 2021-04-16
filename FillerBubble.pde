class FillerBubble{
  //variables
  float bx;
  float by;
  float vy, vx;
  float diameter;
  boolean active;
  boolean popped;
  boolean growing;
  
  //physics
  float gravity = -0.05;
  float friction = -0.25;
  
  //constructor
  FillerBubble(float x, float y){
    bx = x;
    by = y;
    active = true;
    diameter = 10;
    popped = false;
    growing = true;
  }
  boolean getGrowth(){
    return growing;
  }
  boolean getPopped(){
    return popped;
  }
  boolean getState(){
     return active;
   }
  float getDiameter(){
     return diameter;
   }
  float getX(){
     return bx;
   }
  float getY(){
     return by;
   }
  //change state of bubble
  void changeState(){
     active = false;
   }
  //increases radius size
  void update(){
   diameter++;
  }
  
  //move bubble to specified location, if out of bounds it will be stuck on boundary
  void drag(float x, float y){
    if(mouseX < width - diameter/2){
      bx = x;
    }
    else if (mouseX > width){
      bx = width - diameter/2;
    }
    if(mouseX < 0 + diameter/2){
      bx = 0 + diameter/2;
    }
   if(mouseY < height - diameter/2){
    by = y;
    }
    else if (mouseX > height){
      by = height - diameter/2;
    }
    if(mouseY < 0 + diameter/2){
      by = 0 + diameter/2;
    }
  }
  //bubble physic mechanics when they are created
  void move(){
    if(!active){
      vy += gravity;
      bx += vx;
      by += vy;
      
    if (bx > width - diameter/2) {
      bx = width - diameter/2;
      vx *= friction; 
    } 
    else if (bx < diameter/2){
      bx = diameter/2;
      vx *= friction; 
    } 
    else if (by > height - diameter/2) {
      by = height - diameter/2;
      vy *= friction; 
    } 
    else if (by < diameter/2) {
      by =  diameter/2;
      vy *= friction; 
    }
    }
  }
  
  //collision detection amongst the other bubbles
  void collide(){
    for (int i = 0; i < bubble.size(); i++) {
      if(!bubble.get(i).getState() && !getState()){
      float dx = bubble.get(i).getX() - bx;
      float dy = bubble.get(i).getY() - by;
      
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = (bubble.get(i).getDiameter())/2 + diameter/2;
      
      if (distance <= minDist) { 
        float angle = atan2(dy, dx);
        float targetX = bx + cos(angle) * minDist;
        float targetY = by + sin(angle) * minDist;
        float ax = (targetX - bubble.get(i).getX()) * 0.1;
        float ay = (targetY - bubble.get(i).getY()) * 0.1;
        
        vx -= ax;
        vy -= ay;
        bubble.get(i).vx += ax;
        bubble.get(i).vy += ay;
        }
      }
      //if a growing bubble touches a inactive bubble, it stops growing
      if((!bubble.get(i).getState() && getState())){
        float distance = dist(bubble.get(i).getX(), bubble.get(i).getY(), bx, by);
     if(distance < (bubble.get(i).getDiameter()/2 + diameter/2)){    
           growing = false;
           changeState();
         }
      }
    }   
  }
  //if bubble was popped from a mine during growth
  void popped(){
    diameter = 0;
    active = false;
    popped = true;
  }
  //bubble display
  void display(){
    noFill();
    stroke(#ee81b7);
    strokeWeight(3);
    ellipse(bx, by, diameter, diameter);
  }
}
