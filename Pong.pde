//------------BOOLS ZUM ÖFFNEN VON MENÜS, STARTEN DES SPIELES UND TASTEN FÜRS STEUERN DER PADDLES--------------------------
boolean gameStarted = false;
boolean customPressed = false;
boolean modiPressed = false;
boolean customStarted = false;
boolean wPressed = false;
boolean sPressed = false;
boolean oPressed = false;
boolean lPressed = false;
boolean lefthit = false;
boolean righthit = false;

//------------INITIALISIERUNG VERSCHIEDENSTER VARIABLEN UND KLASSEN-------------------------------------
Paddle paddle;
Ball ball;
Game game;
ButtonsAndMenus BAM;
float random = 0;
PImage backgroundImage;
int paddleWidth = 20;
int paddleHeight = 120;
int ballSize = 30;
int leftPaddleY, rightPaddleY;
float ballX, ballY;
float ballSpeedX = 4;
float ballSpeedY = random;
float paddleSpeed = 5;
int leftScore = 0;
int rightScore = 0;
int entireScore = 0;
int Level = 1;
int nextPaddleSpeedLevel = 0;
int lastLevelTime = 0;

//------------------KLASSEN FÜR OBJEKTE, KNÖPFE UND SPIELFUNKTIONEN---------------------------

class Paddle {
//...............................ERSTELLT DAS PADDLE................................
  
  void create() {
    fill(255);
    rect(30, leftPaddleY, paddleWidth, paddleHeight);
    rect(width - 50, rightPaddleY, paddleWidth, paddleHeight);
  }

//..............WOHIN SICH DIE PADDLES BEWEGEN UND WIE SCHNELL SIE DAS TUN.............

  void move() {
    if (wPressed) {
      leftPaddleY -= paddleSpeed;
    }
    if (sPressed) {
      leftPaddleY += paddleSpeed;
    }
    if (oPressed) {
      rightPaddleY -= paddleSpeed;
    }
    if (lPressed) {
      rightPaddleY += paddleSpeed;
    }
  }

//..........LÄSST DAS PADDLE NICHT AUS DEM FENSTER ENTKOMMEN.....................

  void bleibImFenster() {
    leftPaddleY = constrain(leftPaddleY, 0, height - paddleHeight);
    rightPaddleY = constrain(rightPaddleY, 0, height - paddleHeight);
  }
}

class Ball { 
//........................ERSTELLT DEN BALL......................................
  
  void create() {
    ellipse(ballX, ballY, ballSize, ballSize);
  }

//....LÄSST DEN BALL BEWEGEN, IHN VON DER WAND BOUNCEN UND MACHT DIE SCORES......

  void move() {
    ballX += ballSpeedX;
    ballY += ballSpeedY;

    if (ballY < 0 || ballY > height) {
      ballSpeedY *= -1;
    }
    if (ballX < 10) {
      rightScore++;
      resetBall();
    } 
    else if (ballX > width-10) {
      leftScore++;
      resetBall();
    }
  }


//.....................SETZT DEN BALL AN DIE AUSGANGSPOSITION.....................

  void resetBall() {
    delay(1500);
    ballX = width / 2;
    ballY = height / 2;
    ballSpeedX *= -1;
    random = random(3, 6);
    ballSpeedY = random;
  }
}

class ButtonsAndMenus{
  
//.............................ZEICHNET EINEN KNOPF................................
  
  void drawButton(float x, float y, float w, float h, String label) {
    fill(100);
    rect(x, y, w, h, 10);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(32);
    text(label, x + w / 2, y + h / 2);
  }

//.......................IST DIE MAUS AUF DEM KNOPF?...............................

  boolean overButton(float x, float y, float w, float h) {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    } 
    else {
      return false;
    }
  }
  
//.........................MACHT EIN HAUPTMENÜ......................................
  
  void showMainMenu() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("Pong Game", width / 2, height / 8);
    textSize(32);
    text("Klicke auf den Startknopf, um zu beginnen", width / 2, height / 8 + 80);
    drawButton(width / 2 - 100, height / 2 - 50, 200, 100, "Start");
    drawButton(width / 6, height / 2 - 50, 200, 100, "Custom");
    drawButton(width / 1.4, height / 2 - 50, 200, 100, "Modes");
  }

//.................MACHT DAS UNTERMENÜ FÜR CUSTOM SPIELOPTIONEN....................

  void showCustomMenu() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("Custom Menu", width / 2, height / 8);
    textSize(32);
    text("Klicke auf den Startknopf, um mit benutzerdefinierten Einstellungen zu beginnen", width / 2, height / 8 + 80);
    drawButton(width - 250, height - 150, 200, 100, "Start");
    drawButton(width / 2 - 450, height / 2 - 40, 200, 100, "<-");
    drawButton(width / 2 + 250, height / 2 - 40, 200, 100, "->");
    textSize(128);
    text(Level, width / 2, height / 2);
  }
  
//.................MACHT DAS UNTERMENÜ FÜR CUSTOM SPIELOPTIONEN....................
  
  void showModiMenu() {
      background(0);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(64);
      text("Modes", width / 2, height / 8);
      textSize(32);
      text("Wähle einen Modus", width / 2, height / 8 + 80);
      drawButton(width / 2 - 100, height / 2 - 40, 200, 100, "Easy Obstacles");
      drawButton(width / 2 - 450, height / 2 - 40, 200, 100, "Singleplayer");
      drawButton(width / 2 + 250, height / 2 - 40, 200, 100, "Hard Obstacles");
    }
}

class Game {
  
//..............................HAT DAS PADDLE DEN BALL GEHITTED?........................................
  
  void checkCollisions() {
    //linkes paddle
    if (ballX - ballSize / 2 < 30 + paddleWidth && ballY > leftPaddleY && ballY < leftPaddleY + paddleHeight && lefthit == false) {
      ballSpeedX *= -1;
      lefthit = true;
      righthit = false;
    }

    //rechtes paddle
    if (ballX + ballSize / 2 > width - 50 && ballY > rightPaddleY && ballY < rightPaddleY + paddleHeight && righthit == false) {
      ballSpeedX *= -1;
      righthit = true;
      lefthit = false;
    }
  }


//....................................DAS IST DER SCORE......................................
  void displayScores() {
    textSize(64);
    fill(255, 0, 0);
    text(leftScore, width / 4, 50);
    text(rightScore, 3 * width / 4, 50);
    text(Level, width / 2, 50);
  }
  
//.............DIESES VOID LÄSST DAS LEVEL ALLE 20 SEKUNDEN UM 1 NACH OBEN GEHEN............

  void level() {
    if (millis() - lastLevelTime >= 20000) { // 20000 Millisekunden = 20 Sekunden
      ballSpeedX *= 1.1;
      ballSpeedY *= 1.1;
      Level++;
      lastLevelTime = millis();
    }

    if (Level == nextPaddleSpeedLevel+6) {
      paddleSpeed += 4;
      nextPaddleSpeedLevel += 6;
    }
  }
}

class obsicles {
  
}

//---------------------------------TASTENABFRAGEN--------------------------------------------------
void keyPressed() {
  if (key == 'w' || key == 'W') {
    wPressed = true;
  }
  if (key == 's' || key == 'S') {
    sPressed = true;
  }
  if (key == 'o' || key == 'O') {
    oPressed = true;
  }
  if (key == 'l' || key == 'L') {
    lPressed = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    wPressed = false;
  }
  if (key == 's' || key == 'S') {
    sPressed = false;
  }
  if (key == 'o' || key == 'O') {
    oPressed = false;
  }
  if (key == 'l' || key == 'L') {
    lPressed = false;
  }
}

void mousePressed() {
  if (!gameStarted && !customPressed && !modiPressed && BAM.overButton(width / 2 - 100, height / 2 - 50, 200, 100)) {
    gameStarted = true;
  }
  if (!gameStarted && !modiPressed && BAM.overButton(width / 6, height / 2 - 50, 200, 100)) {
    customPressed = true;
  }
  if (customPressed && !modiPressed && !gameStarted && BAM.overButton(width - 250, height - 150, 200, 100)) {
    for(int i = 0; i < Level; i++){
      ballSpeedX *= 1.1;
      ballSpeedY *= 1.1;
    }
    gameStarted = true;
  }
  if (customPressed && !gameStarted && BAM.overButton(width / 2 - 450, height / 2 - 40, 200, 100)) {
    Level--;
  }
  if (customPressed && !gameStarted && BAM.overButton(width / 2 + 250, height / 2 - 40, 200, 100)) {
    Level++;
  }
  if (!customPressed && !gameStarted && BAM.overButton(width / 1.4, height / 2 - 50, 200, 100)) {
    modiPressed = true;
  }
}

//---------------------SPIELSTARTUP UND DRAW SCHLEIFE---------------------------------------------------

void setup() {
  size(1600, 800);
  backgroundImage = loadImage("landscape.jpg");
  backgroundImage.resize(width, height);
  paddle = new Paddle();
  ball = new Ball();
  game = new Game();
  BAM = new ButtonsAndMenus();
  ball.resetBall();
  leftPaddleY = height / 2 - paddleHeight / 2;
  rightPaddleY = height / 2 - paddleHeight / 2;
  frameRate(144);
  lastLevelTime = millis(); // Initialisierung des Zeitstempels
}

void draw() {
  if (!gameStarted) {
    BAM.showMainMenu();
    if (customPressed && !gameStarted && !modiPressed) {
      BAM.showCustomMenu();
    }
    if (modiPressed && !gameStarted && !customPressed) {
      BAM.showModiMenu();
    }
  }
  if (gameStarted) {
    background(backgroundImage);
    paddle.create();
    paddle.move();
    paddle.bleibImFenster();
    ball.create();
    ball.move();
    game.checkCollisions();
    game.displayScores();
    game.level();
  }
}
