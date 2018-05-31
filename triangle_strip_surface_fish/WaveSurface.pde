// Andrew Craigie
// WaveSurface.pde

// A class that creates the data for, and renders, a triangle strip surface

class WaveSurface {

  float areaWidth;
  float areaDepth;

  int tileCols;
  int tileRows;

  float tileWidth;
  float tileDepth;

  float maxDistance;

  ArrayList<ArrayList<Location>> locations;

  float colIncrement = 0;
  float colIncrement2 = 0;

  float maxHeight = 100;

  float posX = 0.0;
  float posY = 0.0;
  float posZ = 0.0;



  WaveSurface(float areaWidth, float areaDepth, int numCols, int numRows) {

    this.areaWidth = areaWidth;
    this.areaDepth = areaDepth;
    this.tileCols = numCols;
    this.tileRows = numRows;

    this.locations = new ArrayList<ArrayList<Location>>();

    this.maxDistance = dist(0, 0, tileCols, tileRows) / 2;
    this.tileWidth = this.areaWidth / this.tileCols;
    this.tileDepth = this.areaDepth / this.tileRows;

    initializeTerrain();
  }


  void initializeTerrain() {

    for (int z = 0; z < this.tileRows; z++) {

      // Add a row of locations
      ArrayList<Location> rowLocs = new ArrayList<Location>();
      this.locations.add(rowLocs);

      // Add locations
      for (int x = 0; x < this.tileCols; x++) {

        float d = dist(this.tileRows / 2, this.tileCols / 2, z, x);
        float normDist = map(d, 0, this.maxDistance, 0.0, 1.0);
        float tempY = sin(map(normDist, 0.0, 1.0, -TWO_PI, TWO_PI));

        PVector l = new PVector(x, tempY * this.maxHeight, z);

        pushStyle();
        colorMode(HSB, 1.0, 1.0, 1.0);
        color c = color(0.0, 0.0, 1.0);
        popStyle();

        Location loc = new Location(l, c, d, normDist);
        rowLocs.add(loc);
      }
    }
  }

  void show(PVector loc, float maxHeight, float colIncrement) {
    
    this.maxHeight = maxHeight;
    this.colIncrement = colIncrement;

    for (int r = 0; r < this.locations.size() - 1; r++) {

      // Get top of strip locations array list
      ArrayList<Location> tLocs = this.locations.get(r);
      // Get the next row too
      ArrayList<Location> bLocs = this.locations.get(r + 1);

      // Begin a new traiangle strip

      beginShape(TRIANGLE_STRIP);

      for (int c = 0; c < tLocs.size(); c++) {

        Location tl = tLocs.get(c);
        Location bl = bLocs.get(c);

        pushStyle();
        colorMode(HSB, 1.0, 1.0, 1.0);
        
        // Experimenting with variables to create motion and colour changes

        float colorHue = map(sin(tl.normDist + this.colIncrement * 0.1), -1, 1, 0.0, 1.0);
        color tc = color(colorHue, 1.0, 1.0);
        color bc = color(colorHue, 1.0, 1.0);

        float tx = (tl.loc.x * this.tileWidth) - (this.areaWidth / 2) + (this.tileWidth / 2);

        float tSin = sin(map(tl.normDist, 0.0, 1.0, -TWO_PI, TWO_PI));

        float ty = sin(tSin + this.colIncrement) * this.maxHeight * tl.normDist;

        float tz = (tl.loc.z * this.tileDepth) - (this.areaDepth / 2) + (this.tileDepth / 2);
        float bx = (tl.loc.x * this.tileWidth) - (this.areaWidth / 2) + (this.tileWidth / 2);

        float by = sin(tSin + this.colIncrement) * this.maxHeight * bl.normDist;
        float bz = (bl.loc.z * this.tileDepth) - (this.areaDepth / 2) + (this.tileDepth / 2);

        // Play with colour values

        float tAlpha = map(tl.normDist, 0.0, 1.0, 255, 10); // need to check effect of colorMode
        float bAlpha = map(bl.normDist, 0.0, 1.0, 255, 10);

        float tSat = map(tl.normDist, 0.0, 1.0, 1.0, 0.0);
        float bSat = map(bl.normDist, 0.0, 1.0, 1.0, 0.0);

        float hueT = hue(tc);
        float hueB = hue(bc);
       

        noStroke();

        fill(hueT, tSat, 1.0, tAlpha);
        vertex(tx + loc.x, ty + loc.y, tz + loc.z);

        fill(hueB, bSat, 1.0, bAlpha);
        vertex(bx + loc.x, by + loc.y, bz + loc.z);

        popStyle();
      }
      
      endShape();
      this.colIncrement2 += 0.002;
      
    }
  }
}
