// when THIS PLAYER makes a normal move
void normalMove() { 
  bLastEaten = grid[row2][col2];
  grid[row2][col2] = grid[row1][col1];
  grid[row1][col1] = ' ';

  promo = checkPawnPromo(); //returns true if pawn at row 0
  System.out.println(promo);

  myClient.write(str(row1)+str(col1)+str(row2)+str(col2)+"0");
  takeback = true;
  firstClick = true;
  myTurn = false;
}


// when THIS PLAYER takes back its last move
void takeBack() {  
  char temp = grid[row1][col1];
  grid[row1][col1] = grid[row2][col2];

  if (Character.isUpperCase(bLastEaten))
    grid[row2][col2] = bLastEaten;    
  else grid[row2][col2] = temp;

  myClient.write(str(row2)+str(col2)+str(row1)+str(col1)+"1");
  myTurn = true;
}


// when THIS PLAYER invokes a pawn promotion
void pawnPromo() {
  // the pawn is at row2 col2
  if (key=='q' || key=='Q') {
    grid[row2][col2] = 'q';
    type = 0;
  } else if (key=='r' || key=='R') {
    grid[row2][col2] = 'r';
    type = 1;
  } else if (key=='k' || key=='K') {
    grid[row2][col2] = 'n';
    type = 2;
  } else if (key=='b' || key=='B') {
    grid[row2][col2] = 'b';
    type = 3;
  }
    else return;
    
  myClient.write(str(row2)+str(col2)+str(type)+str(col1)+"2");
  promo = false;
  myTurn = false;
}


boolean checkPawnPromo() {
  for (int i=0; i<grid[0].length; i++) {
    if (grid[0][i] == 'p') return true;
  }  
  return false;
}
