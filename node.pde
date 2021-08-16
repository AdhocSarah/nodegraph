class node {
  final static int NODE_RADIUS = 50;
  int x, y;
  String name;
  ArrayList<link> links;
  boolean hasCoords;
  
  node(String name) {
    this.name = name;
    this.hasCoords = false;
    this.links = new ArrayList();
  }
  
  node(String name, int x, int y) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.hasCoords = true;
    this.links = new ArrayList();
  }
    
  node traverseIndex(int linkIndex) {
    if (linkIndex > this.links.size()) return null;
    link currLink = this.links.get(linkIndex);
    if ((currLink.a == this && currLink.dir == -1) || (currLink.b == this && currLink.dir == 1)) return null;
    return currLink.a == this ? currLink.b : currLink.a;  
}

  node traverseNode(String name) {
    node output = null;
    for (link currLink : this.links) {
      if (currLink.hasNode(name)) {
        node tempNode = currLink.getNode(name);
        if (currLink.canTraverse(this, tempNode)) {
          output = tempNode;
          break;
        }
      }
    }
    return output;
  }
  
  void addCoords(int x, int y) {
    this.x = x;
    this.y = y;
    this.hasCoords = true;
    
  }
  
  
  void draw(boolean toLink) {
    if (this.hasCoords) {
      fill(255);
      if (toLink) circle(this.x, this.y, NODE_RADIUS+10);
      circle(this.x, this.y, NODE_RADIUS);
      fill(0);
      textAlign(CENTER, CENTER);
      text(this.name, this.x, this.y);
    }
    
  } 
  
  boolean isClicked(int mX, int mY){
    if (this.hasCoords) {
      float distSq = pow(this.x-mX, 2)  + pow(this.y-mY, 2);
      return distSq < pow(NODE_RADIUS, 2);
    }
    return false;
  }
  


}
