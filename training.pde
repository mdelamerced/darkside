class light {

  void goOver() {
    image(backgroundImage, 0, 0);
    image(saber, width/3, height/2);
    kinect.update();
    // image(kinect.depthImage(), 0, 0);
    text(youAre, 100, 100);
    IntVector userList = new IntVector();
    kinect.getUsers(userList);

    if (userList.size() > 0) {
      phase = 2;
      phase++;
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
        //lightsaber.drawSaber;
        // A vector that points to the mouse location
        PVector mouse = new PVector(mouseX, mouseY);
        // A vector that points to the center of the window
        PVector center = new PVector(width/2, height/2);
        // Subtract center from mouse which results in a vector that points from center to mouse
        handVec.sub(center);
        // Normalize the vector
        handVec.normalize();
        // Multiply its length by 50
        handVec.mult(250);
        translate(mouseX, mouseY);
        // Draw the resulting vector
        stroke(255, 0, 0);
        strokeWeight(10);
        line(0, 0, handVec.x, handVec.y);
        /*   translate(myPositionScreenCoords.x, myPositionScreenCoords.y);
         stroke(0);
         branch(50);
         println(myPositionScreenCoords.x);
         println(myPositionScreenCoords.y);*/
        //  noLoop();

        //draw toxiclibs particles
        /*   physics.update ();
         attractor.display();
         for (Particle p: particles) {
         p.display();
         }
         attractor.set(myPositionScreenCoords.x, myPositionScreenCoords.y);
         }
         }*/
      }
    }
  }
}

