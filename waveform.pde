import processing.sound.*;
SoundFile file;
Amplitude amp; 

int l = 0;
int h = 360;
int speed = 1; //Speed of the song (The higher the number, the shorter the image
int framerate = 60;

String name = "Everything"; //Name of File

void settings() {
  file = new SoundFile(this, name + ".wav");
  size(int(file.duration()/speed*framerate), h);
  l = int(file.duration()/speed*framerate); //length of song in seconds (sped up by 12) * 60 fps;
}

void setup() {
  background(30,40,90);
  frameRate(framerate);
    
  //Song file stuff
  file.play();
  file.rate(speed);
  
  //Amplitude stuff
  amp = new Amplitude(this);
  amp.input(file);
}      

//Variables
int x = 0;
float average = 0;

int thickness = 3; //Thickness of Line
int spacing = 4; //Space between lines

void draw() {
    strokeWeight(thickness);
    stroke(220,180,0); //Color of Lines
    
    average = average + amp.analyze(); //Average amplitude of each line
    
    //Prints line every (thickness+spacing) pixels
    if(x%(thickness+spacing) == 0) {
      average = average / (thickness+spacing);
      
      int line = int(h*average);
      line(x,(h/2)-(line/2),x,(h/2)+(line/2)); //Line gets printed in the middle
      
      average = 0;
    }
    
    x++;
    
    //Saves image once wave has reached end of the canvas
    if(x > l) {
      save(name + "Wave.png");
    }
}