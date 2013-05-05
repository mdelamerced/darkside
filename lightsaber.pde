class lightsaber {

  void drawSaber() {
    // A vector that points to the mouse location
    PVector mouse = new PVector(mouseX, mouseY);
    // A vector that points to the center of the window
    PVector center = new PVector(width/2, height/2);
    // Subtract center from mouse which results in a vector that points from center to mouse
    //  mouse.sub(center);
    handVec.sub(center);

    // Normalize the vector
    //  mouse.normalize();
    handVec.normalize();

    // Multiply its length by 50
    // mouse.mult(250);
    handVec.mult(250);

    translate(handVec.x, handVec.y);
    // Draw the resulting vector
    stroke(255, 0, 0);
    strokeWeight(10);
    line(0, 0, handVec.x, handVec.y);
  }
}

