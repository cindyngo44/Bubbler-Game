class LoadGame{
   boolean easy;
   boolean hard;
   boolean win;
   boolean lose;
   
   float bubbleArea;
   float area;
   int lives;
   int bubbles;
   
   ArrayList<Mines> mines = new ArrayList<Mines>();
   
  //defines the game mode and loads the game mode mechanics
  LoadGame(int mode){
     area = 0;
     lives = 5; 
     win = false;
     lose = false;
    if(mode == 0){
      easy = true;
      bubbles = 20;
      
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      }
    if(mode == 1){
      hard = true;
      bubbles = 50;
      
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      mines.add(new Mines());
      }
  }
  //getters
    boolean getWin(){
    return win;
  }
    boolean getLose(){
    return lose;
  }
  //displaying the "board" of the game
  void display(){    
      background(#fefaf9);
      
      textFont(font, 24);
      fill(#ee81b7);
      text("Filled:  " + area + "%", 10, 25);
      text("Bubbles:  " + bubbles, 10, 50);
      text("Lives:  " + lives, 10, 75);
      
     for(int i = 0; i < mines.size(); i ++){
     Mines mine = mines.get(i);
     mine.update();
     mine.display();
     mine.collideBoundary();
      
    }
     
  }
  //takes in the bubble radius created and calculates the area
  void bubbleArea(float radius){
  bubbleArea += PI * radius * radius;
  
  //auto updates the area in this function
  calculateArea();
  }
  //calculates area taken up by the bubbles
  void calculateArea(){
    //DEBUG
    //println(area); 
    area = (bubbleArea / 750000) * 100;
  }
  //when called, will subtract 1 from bubble count
  void calculateBubbles(){
    //DEBUG
    //println(bubbles);
    bubbles--;
  }
  //check collision with all mines for active bubbles
  boolean checkCollision(float bx, float by, float br){
    //take bubble x,y, and radius and check against all mines when active
     for(int i = 0; i < mines.size(); i ++){
     Mines mine = mines.get(i);
     
     //if there is a collision (true)
       if(mine.collisionBubble(bx,by,br, mine.getX(), mine.getY(), mine.getR())){
         //subtract a life 
         lives--;
         return true;
       }
     }
     //else return false for that bubble
   return false;
  }
  //check physics of mines against inactive bubbles
  void minePhysics(float bx, float by, float br){
    
    for(int i = 0; i < mines.size(); i ++){
     Mines mine = mines.get(i);
     
     mine.bubblePhysics(bx,by,br, mine.getX(), mine.getY(), mine.getR());
    }
  }
  //victory handler
  boolean checkWinLose(){
    if(area >= 66.33 && bubbles >= 0 && lives > 0){
      win = true;
      return true;
  }
    if(area < 66.33 && (bubbles == 0 || lives == 0)){
      lose = true;
      return true;
    }
    return false;  
  }
}
