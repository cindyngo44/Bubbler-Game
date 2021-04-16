class Mines{
  float mx;
  float my;
  float diameter;
  float vx;
  float vy;
  
  //constructor
  Mines(){
    diameter = 20;
    mx = random(20, 980);
    my = random(20, 730);
    vx = 5;
    vy = 5;
  }
  //return x coordinate
  float getX(){
   return mx;
  }
  float getY(){
   return my;
  }
  float getR(){
   return diameter/2;
  }
  
  //move the ball
  void update(){
    mx += vx;
    my += vy;
  }
  //check boundary collision and reverse direction
  void collideBoundary(){
    if (mx > width - diameter/2) {
    mx = width - diameter/2;
      vx *= -1;
    } 
    else if (mx < diameter/2){
      mx = diameter/2;
      vx *= -1;
    } 
    else if (my > height - diameter/2) {
      my = height - diameter/2;
      vy *= -1;
    } 
    else if (my < diameter/2) {
      my =  diameter/2;
      vy *= -1;
    }
  }
  //check collision on active bubbles
  boolean collisionBubble(float bx, float by, float br, float mxx, float myy, float mr){
    float distance = dist(bx, by, mxx, myy);
     if(distance < (br + mr)){
       return true;
     }
     else{
     return false;
     }
  }
  //check collisions with inactive bubbles, reverse direction without affecting the bubble
  void bubblePhysics(float bx, float by, float br, float mxx, float myy, float mr){
     float distance = dist(bx, by, mxx, myy);
     if(distance < (br + mr)){       
        vx *= -1;
        vy *= -1;
        
        mx += vx;
        my += vy;
      }
      //if mine gets stuck respawn it
     if(distance < (br + mr - 40)){
       mx = 980;
       my = 730;
     }
  }
  void display(){
    fill(#9b98bf);
    noStroke();
    ellipse(mx, my, diameter, diameter);
  }
}
