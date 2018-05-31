// Andrew Craigie
// Location.pde

// Simple object holding a location and color

class Location {
  
  PVector loc;
  color col;
  float distFromOrigin;
  float normDist;
  
  Location(PVector loc, color col, float distFromOrigin, float normDist) {
    this.loc = loc;
    this.col = col;
    this.distFromOrigin = distFromOrigin;
    this.normDist = normDist;
    
  }
  
}
