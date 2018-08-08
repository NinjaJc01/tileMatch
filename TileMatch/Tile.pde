class Tile {
  int[] pos = new int[2];
  int colour;
  Tile(int[] position, int colour) {
    this.pos = position;
    this.colour = colour;
  }
  void swap(Tile swapWith) {
    //check adjacency
    int[] tempPos = this.pos;
    this.pos = swapWith.pos;
    swapWith.pos = tempPos;
    board[this.pos[0]][this.pos[1]] = this;
    board[swapWith.pos[0]][swapWith.pos[1]] = swapWith;
  }
  String toString() {
    return("X:"+(this.pos[0])+"Y:"+(this.pos[1])+"Colour:"+this.colour);
  }
}

static boolean isAdjacent(Tile tileA, Tile tileB) {
  int xValA = tileA.pos[0];
  int yValA = tileA.pos[1];
  int xValB = tileB.pos[0];
  int yValB = tileB.pos[1];
  println(abs(xValA - xValB));
  println(abs(yValA - yValB));
  if ((abs(xValA - xValB) == 1)  && (yValB == yValA)) { //check if they're next to eachother
    return true;
  } else if ((abs(yValA - yValB)==1) && (xValB == xValA)) { //check if they're on top of eathother
    return true;
  } else {
    return false;
  }
}