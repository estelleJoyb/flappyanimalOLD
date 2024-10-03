import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  FlutterSecureStorage storage = const FlutterSecureStorage();
  double idPlayer = 0;

  Game();

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

  void setScore(int s) async {
    score = s;
    await storage.write(key: "score", value: s.toString());
  }

  void setBirdWidth(double w) {
    birdWidth = w;
  }

  void setBirdHeigth(double h) {
    birdHeight = h;
  }

  Future<void> setIdPlayer(double id) async {
    idPlayer = id;
    await storage.write(key: "idPlayer", value: id.toString());
  }

  Future<int> getScore() async {
    String? scoreStr = await storage.read(key: "score");
    if (scoreStr == null) {
      return 0;
    }
    return int.parse(scoreStr);
  }

  Future<double> getIdPlayer() async {
    String? idStr = await storage.read(key: "idPlayer");
    if (idStr == null) {
      return 0;
    }
    return double.parse(idStr);
  }

  void removeScoreFromStorage() async {
    await storage.delete(key: 'score');
  }

  void exit() async {
    await storage.delete(key: 'idPlayer');
    await storage.delete(key: 'score');
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
    newGame.storage = storage;
    newGame.idPlayer = idPlayer;
    return newGame;
  }
}
