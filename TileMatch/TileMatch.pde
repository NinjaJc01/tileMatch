Tile[][] board = new Tile[10][10]; //Board //<>// //<>//
int tileWidth = 30;
int border = 2;
int[] selected = {-1, -1};
color[] colours = {
  color(102, 194, 165), 
  color(252, 141, 98), 
  color(141, 160, 203), 
  color(231, 138, 195), 
  color(166, 216, 84), 
  color(255, 217, 47), 
  color(229, 196, 148), 
  color(179, 179, 179)
};
color backCol = color(255, 255, 255);
void settings() {
  size((tileWidth+border)*12, (tileWidth+border)*12);
}
void setup() {
  background(backCol);
  initBoard();
  println(-1/10);
}
void initBoard() {
  for (int i = 0; i<10; i++) {
    for (int j = 0; j<10; j++) {
      board[i][j]=new Tile(new int[]{i, j}, int(random(0, 7)));
    }
  }
}
void draw() {
  updateBoard();
  //delay(10);
}
void updateBoard() {
  clear();
  background(backCol);
  seekAndDestroy();
  //println("Updating");
  drawBoard();
}
int[] mouseToGrid() {
  return(new int[]{floor(map(mouseX, 0, ((tileWidth+border)*12), -1, 11)), floor(map(mouseY, 0, ((tileWidth+border)*12), -1, 11))});
}
void mouseReleased() {
  println("clicked");
  int[] old_sel = selected;
  int[] temp = mouseToGrid();
  if (temp[0] == old_sel[0] && temp[1] == old_sel[1]) {
    selected = new int[]{-1, -1};
  } else {
    selected = temp;
  }
  //selected = mouseToGrid();
  if (isAdjSpecial(old_sel, selected)) {
    if ((old_sel[0]/10 == 0)&&(old_sel[1]/10 == 0)&&(selected[0]/10 == 0)&&(selected[1]/10 == 0)&&(!(old_sel[0]==-1 || old_sel[1]==-1 || selected[0]==-1 || selected[1]==-1))) { //check if the old and new selections will map to a tile, if they're on the board
      println("Were adjacent");
      board[old_sel[0]][old_sel[1]].swap(board[selected[0]][selected[1]]);
      println("swapped");
    }
  }
}
boolean isAdjSpecial(int[] prev, int[] next) {
  if ((abs(prev[0]- next[0]) == 1)  && (next[1] == prev[1])) { //check if they're next to eachother
    return true;
  } else if ((abs(prev[1] - next[1])==1) && (next[0] == prev[0])) { //check if they're on top of eathother
    return true;
  } else {
    return false;
  }
}
void drawBoard() {
  for (Tile[] row : board) {
    for (Tile t : row) {
      drawTile(t);
    }
  }
}
void delTile(Tile t) {
  board[t.pos[0]][t.pos[1]] = null;
}
void doFall(Tile t) {
  if (board[t.pos[0]][t.pos[1]-1]==null) {
    t.pos[1]--;
  }
}
void seekAndDestroy() {
  for (Tile[] row : board) {
    int streak = 0;
    for (Tile t : row) {
      int adj = -1;
      if (t.pos[0] < 9) {
        adj = row[t.pos[0]+1].colour;
        println(adj);
      } else {
        adj = -1; 
        break;
      }
      if (row[t.pos[0]].colour == adj) {
        streak++;
      } else {
        if (streak > 2) {
          println(streak);
          for (int counter = streak; counter > 0; counter--) {
            println("deleted tile");
            delTile(board[t.pos[0]-counter][t.pos[1]]);
          }
          streak = 0;
        }
      }
    }
  }
}
boolean selected_(Tile t) {
  return (t.pos[0]==selected[0])&&(t.pos[1]==selected[1]);
  //return false;
}
void drawTile(Tile tile) {
  if (tile == null) {
    println("null");
  } else if (selected_(tile)) {
    strokeWeight(4);
    stroke(255, 128, 0);
    fill(colours[tile.colour]);
    rect((tile.pos[0]+1)*(tileWidth+border), (tile.pos[1]+1)*(tileWidth+border), tileWidth, tileWidth);
  } else {
    noStroke();
    fill(colours[tile.colour]);
    rect((tile.pos[0]+1)*(tileWidth+border), (tile.pos[1]+1)*(tileWidth+border), tileWidth, tileWidth);
  }
}