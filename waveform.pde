import processing.sound.*;
SoundFile file;
Amplitude amp; 

final int framerate = 60;

int l = 0;
int h = 400; //More visual differnce between high and low frequencies
int speed = 10; //Speed of the song (The higher the number, the shorter the waveform)

String name = "IGOR"; //Name of Song file

void settings() {
  file = new SoundFile(this, name + ".wav");
  size(int(file.duration()/speed*framerate), h);
  l = int(file.duration()/speed*framerate); //length of song in seconds (sped up by 12) * 60 fps;
}

void setup() {
  background(214,151,174);
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

int thickness = 1; //Thickness of Line
int spacing = 0; //Space between lines

void draw() {
    strokeWeight(thickness);
    stroke(0,0,0); //Color of Lines
    strokeCap(ROUND); //Shape of endpoint. Can be rounded [ROUND] Or square [PROJECT]
    
    average = average + amp.analyze(); //Average amplitude of each line
    
    //Prints line every (thickness+spacing) pixels
    if(x%(thickness+spacing) == 0) {
      average = average / (thickness+spacing);
      
      int line = int((h-20)*average);
      line(x,(h/2)-(line/2),x,(h/2)+(line/2)); //Line gets printed in the middle
      
      average = 0;
    }
    x++;
    
    //Saves image once wave has reached end of the canvas
    if(x > l) {
      save(name + "Wave.png");
    }
}
