//Nature of Code Final working library
//Built on SimpleOpenNI and Toxiclibs

//toxiclibs library import
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

//simpleOpenNI kinect
import SimpleOpenNI.*; 
SimpleOpenNI kinect; 
String youAre = "";
PVector handVec = new PVector();
PVector myPositionScreenCoords  = new PVector();

PImage userImage;
int userID;
int[] userMap;
PImage backgroundImage;

//phases
Surrender surrender;
Welcome welcome;


//declare particle array
ArrayList<Particle> particles;
Attractor attractor;

//particleImage
PImage img;

VerletPhysics2D physics;

void setup() {
  //initialize kinect commands
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.alternativeViewPointDepthToImage();
  // backgroundImage = loadImage("deathstar.jpg");
  // backgroundImage = loadImage("carbonite.jpg");
  backgroundImage = loadImage("throneroom.jpg");
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.enableGesture();
  kinect.enableHands();

  //load texture
  img = loadImage("wave.png");
  pose = loadImage("pose.png");

  size(640, 480);
  //   size(720, 486);
  fill(255, 0, 0);
  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
  PFont myFont = createFont("TrajanPro-Bold-48", 32);
  textFont(myFont);

  //toxiclibs particle initialization
  physics = new VerletPhysics2D ();
  physics.setDrag (0.01);

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 50; i++) {
    particles.add(new Particle(new Vec2D(random(width), random(height))));
  }

  attractor = new Attractor(new Vec2D(width/2, height/2));
}
void draw() {
  image(backgroundImage, 0, 0);
  kinect.update();
  // image(kinect.depthImage(), 0, 0);
  text(youAre, 100, 100);
  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (userList.size() > 0) {
    int userId = userList.get(0);

    if ( kinect.isTrackingSkeleton(userId)) {
      PImage rgbImage = kinect.rgbImage();
      rgbImage.loadPixels();
      loadPixels();

      userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
      // loadPixels();
      for (int i = 0; i < userMap.length; i++) {
        if (userMap[i] !=0) {
          pixels[i] = rgbImage.pixels[i];
        }
      }
      updatePixels();
      drawSkeleton(userId);
      //  println(drawSkeleton);
    }

    //   float elbowDistance = getJointDistance(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_LEFT_ELBOW);
    //  float hdist = PVector.dist(leftHand, rightHand);
    //   println(elbowDistance );

    float handDistance = getJointDistance(userId, SimpleOpenNI.SKEL_RIGHT_HAND, SimpleOpenNI.SKEL_LEFT_HAND);
    //  PVector hand = new hand();

    if (handDistance > 350) {
      youAre = "ready'";
    }
    else {
      youAre = "attack";
      translate(myPositionScreenCoords.x, myPositionScreenCoords.y);
      stroke(0);
      branch(50);
      println(myPositionScreenCoords.x);
      println(myPositionScreenCoords.y);
      //  noLoop();

      //draw toxiclibs particles
      physics.update ();
      attractor.display();
      for (Particle p: particles) {
        p.display();
      }
      attractor.set(myPositionScreenCoords.x, myPositionScreenCoords.y);
    }
  }
}

