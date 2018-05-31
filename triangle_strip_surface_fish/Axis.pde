// Andrew Craigie
// Axis class

// Draws x, y and z axis in sketch

class Axis {

  color colX;
  color colY;
  color colZ;

  int strokeW;

  float originX;
  float originY;
  float originZ;

  float xLength;
  float yLength;
  float zLength;

  Axis(float oX, float oY, float oZ, float xL, float yL, float zL, int sWeight) {

    originX = oX;
    originY = oY;
    originZ = oZ;

    xLength = xL;
    yLength = yL;
    zLength = zL;

    strokeW = sWeight;
  }


  void draw(color xCol, color yCol, color zCol) {

    float x1 = originX - (xLength / 2);
    float x2 = originX + (xLength / 2);
    float y1 = originY - (yLength / 2);
    float y2 = originY + (yLength / 2);
    float z1 = originZ - (zLength / 2);
    float z2 = originZ + (zLength / 2);

    // Draw X axis
    pushStyle();
    colorMode(RGB, 255, 255, 255, 255);
    strokeWeight(strokeW);
    stroke(xCol);
    line(x1, originY, originZ, x2, originY, originZ);
    line(x2, originY, originZ, x2 - 20, originY - 10, originZ);
    popStyle();

    // Draw Y axis
    pushStyle();
    colorMode(RGB, 255, 255, 255, 255);
    strokeWeight(strokeW);
    stroke(yCol);
    line(originX, y1, originZ, originX, y2, originZ);
    line(originX, y2, originZ, originX + 10, y2 - 20, originZ);
    popStyle();

    // Draw Z axis
    pushStyle();
    colorMode(RGB, 255, 255, 255, 255);
    strokeWeight(strokeW);
    stroke(zCol);
    line(originX, originY, z1, originX, originY, z2);
    line(originX, originY, z2, originX + 10, originY, z2 - 20);
    popStyle();
    
    
  }
}
