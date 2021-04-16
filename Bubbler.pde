import processing.sound.*;
//loaders
PImage menu, win, lose;
PFont font;
//game booleans
boolean modeMenu, modeEasy, modeHard, gameStart;
//make game objects
LoadGame easy = new LoadGame(0);
LoadGame hard = new LoadGame(1);

//bubble arraylist
ArrayList<FillerBubble> bubble = new ArrayList<FillerBubble>();
SoundFile gameOver;
SoundFile dead;
SoundFile click;
SoundFile bg;
void setup(){
  size(1000,750);
  
  menu = loadImage("Menu.png");
  win = loadImage("Win.png");
  lose = loadImage("Lose.png");
  
  //boolean modes of the screen
  modeMenu = true;
  modeEasy = false;
  modeHard = false;
  gameStart = false;
  
  //bg sound
  bg = new SoundFile(this, "BG_Music.wav");
  bg.loop();
  
  //TO DO: implement these sounds
  dead = new SoundFile(this, "DeadBubble.wav");
  gameOver = new SoundFile(this, "Game_Over.wav");
  click = new SoundFile(this, "click.wav");
  //custom font
  font = loadFont("Small-Pixel-48.vlw");
}

void draw(){
   //load menu
  if(modeMenu){
    menuLoad();
  }
  //load game modes once activated
  if(modeEasy){
    gameStart = true;
    easy.display();
    
      
    //if false continue game, if true move to the display function
    if(easy.checkWinLose()){
      displayWinLose();
    }
   
  }
  if(modeHard){
    gameStart = true;
    hard.display();
    
    if(hard.checkWinLose()){
    displayWinLose();
    }
  }
   //display stored bubbles in the array
  if(gameStart){
  for(int i = 0; i < bubble.size(); i++){
    FillerBubble bub = bubble.get(i);
    //grow the bubble
    if(bub.getState()){
      bub.update(); 
      bub.collide();
    
    //check collision with mines when active
    if(modeEasy){
      if(easy.checkCollision(bub.getX(), bub.getY(), bub.getDiameter()/2)){
        dead.play();  
        bub.popped();        
        }
      }
    if(modeHard){
      if(hard.checkCollision(bub.getX(), bub.getY(), bub.getDiameter()/2)){
        dead.play();    
        bub.popped();        
        }
      }
    }
    //else calculate physics to display
    else{
      bub.move();
      if(modeEasy){
        easy.minePhysics(bub.getX(), bub.getY(), bub.getDiameter()/2);
      }
      if(modeHard){
        hard.minePhysics(bub.getX(), bub.getY(), bub.getDiameter()/2);
      }
      bub.collide();
    }
    bub.display();
    }
  }
}
//Load Menu Screen .png
void menuLoad(){
  background(menu);
}

void mousePressed(){
  click.play();
  //if mouse pressed on menu screen
  float x = mouseX;
  float y = mouseY;
  
  if(mouseButton == LEFT){
    //easy mode activated
    if( x >= (width/4) - 100 && x <= (width/4) + 100 && y >= 480 && y <= 530 && modeMenu){
    modeEasy = true;
    modeMenu = false;
  }
    //hard mode activated
    if( x >= (width/2) - 100 && x <= (width/2) + 100 && y >= 480 && y <= 530 && modeMenu){
    modeHard = true;
    modeMenu = false;
  }
    //exit button
    if( x >= (width * 3/4) - 100 && x <= (width * 3/4) + 100 && y >= 480 && y <= 530 && modeMenu){
    exit();
  }
    //game mode starts
    //mouse pressed during game, bubbles are made, must subtract from LoadGame Bubbles
  if(modeEasy && gameStart){
    easy.calculateBubbles();
    bubble.add(new FillerBubble(mouseX,mouseY));
  }
  if(modeHard && gameStart){
      hard.calculateBubbles();
      bubble.add(new FillerBubble(mouseX,mouseY));
    }
  }
}
//if creating a bubble, bubble center must follow mouse x,y else does nothing
void mouseDragged(){  
  for(int i = 0; i < bubble.size(); i++){
    FillerBubble newBubble = bubble.get(i);
    if(newBubble.getState()){
    newBubble.drag(mouseX, mouseY);
    }
  }
}
//when mouse is released, calculate the area
void mouseReleased(){
  if(modeEasy){
  for(int i = 0; i < bubble.size(); i++){
     FillerBubble bub = bubble.get(i);
     if(!bub.getPopped() && (bub.getState() || !bub.getGrowth())){
     easy.bubbleArea(bub.getDiameter()/2);
     bub.changeState();
     }
    }
  }
  if(modeHard){
  for(int i = 0; i < bubble.size(); i++){
     FillerBubble bub = bubble.get(i);
      if(!bub.getPopped() && (bub.getState() || !bub.getGrowth())){
         hard.bubbleArea(bub.getDiameter()/2);
         bub.changeState();
     }
    }
  }
}
//create the display for win or lose
void displayWinLose(){
  bg.stop();
  //display a you win or you lose screen
  //set all the booleans and then make the right display
  if(easy.getWin()){
    gameStart = false;
    modeEasy = false;
    
    background(win);
  }
  if(easy.getLose()){
     gameOver.play();
     gameStart = false;
     modeEasy = false;
     
     background(lose);
  }
  if(hard.getWin()){
     gameStart = false;
     modeHard = false;
     
     background(win);
  }
  if(hard.getLose()){
     gameOver.play();
     gameStart = false;
     modeHard = false;
     
     background(lose);
  }
}
