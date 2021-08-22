import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;


ArrayList<node> allNodes;
ArrayList<link> allLinks;
// Mode var: 0 = select, 1 = node, 2 = link
int mode;
boolean nodeSelected;
boolean dragging;
node selected;
UiBooster gui;


void setup() {
  size(800, 600);
  textSize(16);
  allNodes = new ArrayList();
  allLinks = new ArrayList();
  gui = new UiBooster();
}

void draw() {
  background(202, 218, 233);
  color(0);
  textAlign(LEFT, UP);
  fill(0);
  text("Mode: " + ((mode == 0) ? "sel" : (mode == 1) ? "node" : "link"), 10, 20);
  for (link currLink : allLinks) {
    currLink.draw();
  }
  color(255);
  for (node currNode : allNodes) {
    currNode.draw(currNode.equals(selected));
  }
}

void keyPressed() {
  if (key == '1') {
    mode = 0;
  } else if (key == '2') {
    mode = 1;
  } else if (key == '3') {
    mode = 2;
  }
}



void mouseDragged() {
  if (mode == 0 && nodeSelected && dragging) {
    selected.addCoords(mouseX, mouseY);
  }
}

void mouseReleased() {
  if (mode == 0) {
    dragging = false;
  }
}

void mousePressed() { 
  if (mode == 0) {
    selected = null;
    for (node currNode : allNodes) {
      if (currNode.isClicked(mouseX, mouseY)) {
        selected = currNode;
        nodeSelected = true;
        dragging = true;
        break;
      }
    }
  }
  if (mode == 1) {
    String name = "";

    name = gui.showTextInputDialog("Please enter the name of the node");
    if (name != null) {
      name = name.trim();
      if (!name.isEmpty()) {
        allNodes.add(new node(name, mouseX, mouseY));
      }
    }
  }
  if (mode == 2) {
    for (node currNode : allNodes) {
      if (currNode.isClicked(mouseX, mouseY)) {
        if (nodeSelected) {
          Integer weight = gui.showSlider("Please select the link weight", "Weight", 0, 20, 0, 5, 1); 
          if (weight != null) {
            String dirString = gui.showSelectionDialog("Please select the directionality of the link", "Direction", "Undirected", "Directed");
            if (dirString != null) {
              int dir = (dirString.equals("Undirected")) ? 0 : 1;
              link newLink = new link(selected, currNode, weight, dir);
              allLinks.add(newLink);
              selected.links.add(newLink);
              currNode.links.add(newLink);
              nodeSelected = false;
              selected = null;
            }
          }
        } else {
          selected = currNode;
          nodeSelected = true;
        }
        break;
      }
    }
  }
}
