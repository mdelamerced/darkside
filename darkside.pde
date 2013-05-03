//Nature of Code Final working library
//Built on SimpleOpenNI and Toxiclibs
/*
//toxiclibs library import
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
*/
//simpleOpenNI kinect
import SimpleOpenNI.*; 
SimpleOpenNI kinect; 
String youAre = "";
PVector handVec = new PVector();
PVector myPositionScreenCoords  = new PVector();
boolean handsTrackFlag = false; 

PImage userImage;
int userID;
int[] userMap;
PImage backgroundImage;
PImage pose;
PImage saber;
PFont myFont;

//images
//int[] backImages new int["throneroom.jpg", "carbonite.jpg", "deathstar.jpg"];

//lightsaber
lightsaber lightsaber;

//phases
int phase = 1;
Surrender Surrender;
light light;
Welcome Welcome;

//declare particle array
//ArrayList<Particle> particles;
//Attractor attractor;

//particleImage
PImage img;

//VerletPhysics2D physics;

void setup() {
  //initialize kinect commands
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.alternativeViewPointDepthToImage();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.enableGesture();
  kinect.enableHands();
  kinect.addGesture("RaiseHand");
  kinect.setMirror(true);

  //initialize phases
  Surrender = new Surrender();
  Welcome = new Welcome();
  light = new light();

  //load texture
  img = loadImage("wave.png");
  pose = loadImage("pose.png");

  //relatedImages
  backgroundImage = loadImage("deathstar.jpg");
  // backgroundImage = loadImage("carbonite.jpg");
  // backgroundImage = loadImage("throneroom.jpg");
  saber = loadImage("lightsaber.png");

 // size(640, 480);
  size(1024, 768);
  fill(255, 0, 0);
  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
  myFont = loadFont("TrajanPro-Bold-48.vlw");
  textFont(myFont);
/*
  //toxiclibs particle initialization
  physics = new VerletPhysics2D ();
  physics.setDrag (0.01);

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 50; i++) {
    particles.add(new Particle(new Vec2D(random(width), random(height))));
  }

  attractor = new Attractor(new Vec2D(width/2, height/2));
  
  */
}
void draw() {

  switch(phase) {
  case 1:
    Surrender.darkStart();
    break;
  case 2:
    light.goOver();
    break;
  case 3:
    Welcome.darkFinish();
    break;
  default:
    phase = 1;
  }
}

void keyPressed() {
  saveFrame("itpDarkLord-####.jpg");
  if (phase==2) {
    phase++;
  }
}

