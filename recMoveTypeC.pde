// when SERVER makes a normal move
void recNormalMove() {
  wLastEaten = grid[c][d];

  grid[c][d] = grid[a][b];
  grid[a][b] = ' ';
  myTurn = true;
}


// when SERVER takes back a move  
void recTakeBack() { 
  char temp = grid[c][d];
  grid[c][d] = grid[a][b];

  if (Character.isLowerCase(wLastEaten)) { //if their last move ate a piece
    grid[a][b] = wLastEaten;
  } else grid[a][b] = temp;

  myTurn = false;
}


// when SERVER invokes a pawn promotion
void recPawnPromo() {
  switch(c) {
  case 7: 
    grid[a][b] = 'Q';
    break;
  case 6:
    grid[a][b] = 'R';
    break;
  case 5:
    grid[a][b] = 'N';
    break;
  case 4:
    grid[a][b] = 'B';
    break;
  }
  myTurn = true;
}
