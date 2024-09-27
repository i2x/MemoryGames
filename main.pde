
//พงษ์จันทร์ จันทร์แจ่ม      6601012610067
int cols = 5;  // Initial number of columns
int rows = 2;  // Initial number of rows
int gridSize = 60;  // Size of each grid square
int[][] grid;
boolean[][] revealed;
boolean firstSelection = true;
int selectedRow1, selectedCol1, selectedRow2, selectedCol2;
boolean gameWon = false;

void settings() {
  size(cols * gridSize, rows * gridSize + 100);  // Set canvas size, add extra space for the menu
}

void setup() {
  grid = new int[rows][cols];
  revealed = new boolean[rows][cols];
  initializeGrid();
  noLoop();  // Only redraw when needed
}

void draw() {
  background(200);
  drawGrid();
  drawMenu();

  if (checkWin()) {
    textSize(24);
    fill(0);
    text("You Win!", width / 2 - 50, height / 2);
    gameWon = true;
  }
}

void mousePressed() {
  if (gameWon) return;
  
  if (mouseY > rows * gridSize) {
    if (mouseX < 100) {  // EASY
      cols = 5;
      rows = 2;
      initializeGrid(); 
      surface.setSize(cols * gridSize, rows * gridSize + 100);
      print("Easy mode selected");
    } else if (mouseX < 200) {  // MID
      cols = 5;
      rows = 4;
      initializeGrid();  
      surface.setSize(cols * gridSize, rows * gridSize + 100);
      print("Mid mode selected");
    } else if (mouseX < 300) {  // HARD
      cols = 5;
      rows = 8;
      initializeGrid();  
      surface.setSize(cols * gridSize, rows * gridSize + 100);
      print("Hard mode selected");
    }
    redraw();
    return;
  }
  
  // Handle grid clicks
  int col = mouseX / gridSize;
  int row = mouseY / gridSize;

  if (col >= cols || row >= rows || revealed[row][col]) return;

  if (firstSelection) {
    selectedRow1 = row;
    selectedCol1 = col;
    revealed[row][col] = true;
    firstSelection = false;
  } else {
    selectedRow2 = row;
    selectedCol2 = col;
    revealed[row][col] = true;
    
    if (grid[selectedRow1][selectedCol1] != grid[selectedRow2][selectedCol2]) {
      delay(500);
      revealed[selectedRow1][selectedCol1] = false;
      revealed[selectedRow2][selectedCol2] = false;
    }
    firstSelection = true;
  }
  
  redraw();
}

void drawGrid() {
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      if (revealed[row][col]) {
        fill(255);
        rect(col * gridSize, row * gridSize, gridSize, gridSize);
        fill(0);
        textSize(20);
        text(grid[row][col], col * gridSize + 24, row * gridSize + 32);
      } else {
        fill(150);
        rect(col * gridSize, row * gridSize, gridSize, gridSize);
      }
    }
  }
}

void drawMenu() {
  fill(0);
  textSize(24);
  text("EASY", 30, rows * gridSize + 40);
  text("MID", 140, rows * gridSize + 40);
  text("HARD", 240, rows * gridSize + 40);
}

void initializeGrid() {
  int[] values = new int[rows * cols];
  for (int i = 0; i < values.length / 2; i++) {
    values[i * 2] = i + 1;
    values[i * 2 + 1] = i + 1;
  }
  values = shuffleArray(values);
  int index = 0;
  
  grid = new int[rows][cols];
  revealed = new boolean[rows][cols];
  
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      grid[row][col] = values[index++];
      revealed[row][col] = false;
    }
  }
}

boolean checkWin() {
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      if (!revealed[row][col]) {
        return false;
      }
    }
  }
  return true;
}

int[] shuffleArray(int[] array) {
  for (int i = 0; i < array.length; i++) {
    int index = int(random(array.length));
    int temp = array[i];
    array[i] = array[index];
    array[index] = temp;
  }
  return array;
}
