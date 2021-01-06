// when CLIENT makes a normal move
void recNormalMove() {
  bLastEaten = grid[c][d];

  grid[c][d] = grid[a][b];
  grid[a][b] = ' ';
  myTurn = true;
}


// when CLIENT takes back their move
void recTakeBack() {
  char temp = grid[c][d];
  grid[c][d] = grid[a][b];

  if (Character.isLowerCase(bLastEaten)) {
    grid[a][b] = bLastEaten;
  } else grid[a][b] = temp;

  myTurn = false;
}


// when CLIENT invokes a pawn promotion 
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
