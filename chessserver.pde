import processing.net.*;
Server myServer;

PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;
boolean firstClick, promo, takeback, myTurn = true;
int row1, col1, row2, col2;
int a, b, c, d, type;
String incoming;
char wLastEaten, bLastEaten; //used for takebacks; last piece eaten
PFont myFont;

char grid[][] = {
  {'R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R'}, // WHITE SIDE IS LOWERCASE
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'}
};

void setup() {
  size(480, 480);
  myServer = new Server(this, 1234);
  firstClick = true;
  myFont = createFont("Arial", 15);

  brook = wrook = loadImage("whiteRook.png"); // same img for W and B
  bbishop = wbishop = loadImage("whiteBishop.png");
  bknight = wknight = loadImage("whiteKnight.png");
  bqueen = wqueen=  loadImage("whiteQueen.png");
  bking = wking =loadImage("whiteKing.png");
  bpawn = wpawn = loadImage("whitePawn.png");
}

void draw() {
  drawBoard();
  drawPieces();
  receiveMove();
}

void receiveMove() {
  Client myclient = myServer.available();
  if (myclient != null) {
    incoming = myclient.readString();
    wLastEaten = 0;

    a = invert(incoming.substring(0, 1));
    b = invert(incoming.substring(1, 2));
    c = invert(incoming.substring(2, 3));
    d = invert(incoming.substring(3, 4));
    int mode = int(incoming.substring(4, 5));

    switch(mode) {
    case 0:
      recNormalMove();
      break;
    case 1:
      recTakeBack();
      break;
    case 2:
      recPawnPromo();
      break;
    default:
      System.out.println("MODE ERROR"+mode);
    }
  }
}

int invert(String n) {
  int num = int(n);
  return abs(num-=7);
}

void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(255); //lb
      } else { 
        fill(220);
      }
      noStroke();
      rect(c*60, r*60, 60, 60);
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {

      if (Character.isUpperCase(grid[r][c])) tint(0,125);
      else tint(0,50);  // differentiates B/W

      if (grid[r][c] == 'r' || grid[r][c] == 'R') image (wrook, c*60+5, r*60+5, 50, 50);
      if (grid[r][c] == 'b' || grid[r][c] == 'B') image (wbishop, c*60+5, r*60+5, 50, 50);
      if (grid[r][c] == 'n' || grid[r][c] == 'N') image (wknight, c*60+5, r*60+5, 50, 50);
      if (grid[r][c] == 'q' || grid[r][c] == 'Q') image (wqueen, c*60+5, r*60+5, 50, 50);
      if (grid[r][c] == 'k' || grid[r][c] == 'K') image (wking, c*60+5, r*60+5, 50, 50);
      if (grid[r][c] == 'p' || grid[r][c] == 'P') image (wpawn, c*60+5, r*60+5, 50, 50);
    }
  }
  if (promo) {
    fill(0, 100);
    rect(0, 0, 480, 480);
    fill(20);
    rect(100, 140, 280, 200);
    fill(255);
    textFont(myFont);
    textSize(20);
    text("Pawn Promotion!", 170, 180);
    rect(130, 200, 220, 40);
    textSize(12);
    text("Q = queen     B = bishop\nK = knight      R = rook", 175, 270);
    fill(0);
    text("select a key to upgrade your pawn", 145, 223);
  }
}

void mouseReleased() {
  if (myTurn) {
    if (firstClick) {
      row1 = mouseY/60;
      col1 = mouseX/60;
      if (Character.isLowerCase(grid[row1][col1])) firstClick = false;
    } else if (!Character.isLowerCase(grid[mouseY/60][mouseX/60])) {
      row2 = mouseY/60;
      col2 = mouseX/60;
      if (!(row2 == row1 && col2 == col1)) {
        normalMove();
      }
    }
  }
}

void keyReleased() {
  if ((key=='z' || key=='Z') && !myTurn && takeback)
    takeBack();
    takeback = false; //this is so that u can only revert the one move
  if (promo) pawnPromo();
}
