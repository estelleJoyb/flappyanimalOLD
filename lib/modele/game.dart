class Game {
  double birdY = 0;
  double time = 0;
  double velocityX = 0;
  double gravity = 0.0004;
  double velocityY = 0;
  double birdWidth = 0.07;
  double birdHeight = 0.05;
  double pipeWidth = 0.2;
  double pipeGap = 0.3; // Ecart entre les tuyaux
  List<List<double>> pipes = [];
  bool gameHasStarted = false;
  bool gameOver = false;
  int score = 0;

  Game(); //constructor

  void setBirdY(double y) {
    birdY = y;
  }

  void setTime(double t) {
    time = t;
  }

  void setVelocityX(double vx) {
    velocityX = vx;
  }

  void setVelocityY(double vy) {
    velocityY = vy;
  }

  void setGravity(double g) {
    gravity = g;
  }

  void setPipeWidth(double pw) {
    pipeWidth = pw;
  }

  void setPipeGap(double pg) {
    pipeGap = pg;
  }

  void setPipes(List<List<double>> p) {
    pipes = p;
  }

  void addPipe(List<double> p) {
    pipes.add(p);
  }

  void setGameHasStarted(bool g) {
    gameHasStarted = g;
  }

  void setGameOver(bool go) {
    gameOver = go;
  }

  void setScore(int s) {
    score = s;
  }

  void setBirdWidth(double w) {
    birdWidth = w;
  }

  void setBirdHeigth(double h) {
    birdHeight = h;
  }

  Game cloneGame() {
    Game newGame = Game();
    newGame.birdY = birdY;
    newGame.birdHeight = birdHeight;
    newGame.birdWidth = birdWidth;
    newGame.velocityY = velocityY;
    newGame.velocityX = velocityX;
    newGame.time = time;
    newGame.score = score;
    newGame.pipes = pipes;
    newGame.pipeWidth = pipeWidth;
    newGame.pipeGap = pipeGap;
    newGame.gravity = gravity;
    newGame.gameOver = gameOver;
    newGame.gameHasStarted = gameHasStarted;
    return newGame;
  }
}
