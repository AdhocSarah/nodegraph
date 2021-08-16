class link {
  final static int DRAW_LINK_WEIGHT = 5;
  node a, b;
  int cost;
  int dir;
  
  link(node a, node b) {
    this.a = a;
    this.b = b;
    this.cost = 0;
    this.dir = 0;
  }
  
  link(node a, node b, int cost, int dir) {
    this.a = a;
    this.b = b;
    this.cost = cost;
    this.dir = dir;
  }
  
  boolean hasNode(String name) {
    return (this.a.name.equals(name)) || (this.b.name.equals(name));
  }
  
  node getNode(String name) {
    return (this.a.name.equals(name)) ? this.a : (this.b.name.equals(name)) ? this.b : null; 
  }
  
  boolean canTraverse(node orig, node dest) {
    return (orig == this.a && dest == this.b) ? this.dir > -1 : (orig == this.b && dest == this.b) ? this.dir < 1 : false;
  }
  
  void draw() {
    stroke(DRAW_LINK_WEIGHT);
    line(this.a.x, this.a.y, this.b.x, this.b.y);
  } 
  
}
