import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/modele/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference score =
    FirebaseFirestore.instance.collection('score');

Game _game = Game();

class GameNotifier extends StateNotifier<Game> {
  GameNotifier() : super(_game);

  void setTime(double t) {
    Game newGame = state.cloneGame();
    newGame.setTime(t);
    state = newGame;
  }

  void setVelocityX(double vx) {
    Game newGame = state.cloneGame();
    newGame.setVelocityX(vx);
    state = newGame;
  }

  void setVelocityY(double vy) {
    Game newGame = state.cloneGame();
    newGame.setVelocityY(vy);
    state = newGame;
  }

  void setGravity(double g) {
    Game newGame = state.cloneGame();
    newGame.setGravity(g);
    state = newGame;
  }

  void setPipeWidth(double pw) {
    Game newGame = state.cloneGame();
    newGame.setPipeWidth(pw);
    state = newGame;
  }

  void setPipeGap(double pg) {
    Game newGame = state.cloneGame();
    newGame.setPipeGap(pg);
    state = newGame;
  }

  void setPipes(List<List<double>> p) {
    Game newGame = state.cloneGame();
    newGame.setPipes(p);
    state = newGame;
  }

  void addPipe(List<double> p) {
    Game newGame = state.cloneGame();
    newGame.addPipe(p);
    state = newGame;
  }

  void setGameHasStarted(bool g) {
    Game newGame = state.cloneGame();
    newGame.setGameHasStarted(g);
    state = newGame;
  }

  void setGameOver(bool go) {
    Game newGame = state.cloneGame();
    newGame.setGameOver(go);
    state = newGame;
  }

  void setScore(int s) {
    Game newGame = state.cloneGame();
    newGame.setScore(s);
    state = newGame;
  }

  void setIdPlayer(double i) {
    Game newGame = state.cloneGame();
    newGame.setIdPlayer(i);
    state = newGame;
  }

  //getters
  bool getGamehasstarted() {
    return state.gameHasStarted;
  }

  bool getGameOver() {
    return state.gameOver;
  }

  Future<int> getScore() {
    return state.getScore();
  }

  double getPipeWidth() {
    return state.pipeWidth;
  }

  double getPipeGap() {
    return state.pipeGap;
  }

  double getBirdY() {
    return state.birdY;
  }

  double getBirdHeight() {
    return state.birdHeight;
  }

  double getBirdWidth() {
    return state.birdWidth;
  }

  List<List<double>> getPipes() {
    return state.pipes;
  }

  Future<double> getIdPlayer() {
    return state.getIdPlayer();
  }

  // actions
  void checkCollisions(int score) {
    Game newGame = state.cloneGame();
    double birdBottom = newGame.birdY + newGame.birdHeight;
    double birdLeft = 0.1;
    double birdRight = birdLeft + newGame.birdWidth;

    for (var pipe in newGame.pipes) {
      double pipeX = pipe[0];
      double pipeGapY = pipe[1];
      double gapBottom = pipeGapY + newGame.pipeGap;

      double pipeLeft = pipeX;
      double pipeRight = pipeLeft + state.pipeWidth;

      bool birdInsidePipeHorizontally =
          birdRight > pipeLeft && birdLeft < pipeRight;

      bool birdHitsTopPipe = newGame.birdY < pipeGapY;
      bool birdHitsBottomPipe = birdBottom > gapBottom;

      if (birdInsidePipeHorizontally &&
          (birdHitsTopPipe || birdHitsBottomPipe)) {
        newGame.gameOver = true;
        newGame.gameHasStarted = false;
      }
    }

    if (newGame.birdY <= 0 || newGame.birdY + newGame.birdHeight >= 1) {
      newGame.gameOver = true;
      newGame.gameHasStarted = false;
    }
    state = newGame;
  }

  void jump() {
    Game newGame = state.cloneGame();
    if (!newGame.gameHasStarted) {
      newGame.gameHasStarted = true;
      newGame.pipes = [];
      newGame.score = 0;
      newGame.birdY = 0.5;
      newGame.gameOver = false;
      newGame.velocityX = 0.01;
      newGame.time = 0;
    } else {
      newGame.velocityY = -0.035;
    }
    state = newGame;
  }

  void initGame() {
    state.removeScoreFromStorage();
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      Game newGame = state.cloneGame();
      if (newGame.gameHasStarted && !newGame.gameOver) {
        newGame.time += 0.016;
        if (newGame.velocityY < 0) {
          newGame.velocityY += newGame.gravity * 10;
        } else {
          newGame.velocityY = min(0.012, newGame.velocityY + newGame.gravity);
        }
        newGame.birdY -= newGame.velocityY;

        if (newGame.pipes.isEmpty || newGame.pipes.last[0] < 0.2) {
          double pipeY = Random().nextDouble() * (1 - newGame.pipeGap);
          newGame.addPipe([1.0, pipeY]);
        }

        for (int i = 0; i < newGame.pipes.length; i++) {
          newGame.pipes[i][0] -= newGame.velocityX;
          if (newGame.pipes[i][0] < -newGame.pipeWidth) {
            newGame.pipes.removeAt(i);
            newGame.score++;
            i--;
          }
        }

        state = newGame;
        checkCollisions(newGame.score);
      }

      if (newGame.gameOver) {
        timer.cancel();
      }
    });
  }

  Future<String?> getUserNameFromIdPlayer(double idPlayer) async {
    QuerySnapshot existingPlayerSnapshot =
        await score.where('id-player', isEqualTo: idPlayer).limit(1).get();
    if (existingPlayerSnapshot.docs.isNotEmpty) {
      var playerData =
          existingPlayerSnapshot.docs.first.data() as Map<String, dynamic>;
      return playerData['nom-joueur'] as String?;
    }
    return null;
  }

  Future<void> changeUserName(double idPlayer, String newName) async {
    if (newName != "") {
      QuerySnapshot existingPlayerSnapshot =
          await score.where('id-player', isEqualTo: idPlayer).limit(1).get();
      if (existingPlayerSnapshot.docs.isNotEmpty) {
        await existingPlayerSnapshot.docs.first.reference.update({
          'nom-joueur': newName,
        });
      }
    }
  }

  Future<void> savePlayerScore([String? playerName]) async {
    double? idPlayer = await getIdPlayer();
    if (idPlayer == 0 && playerName != null) {
      idPlayer = Random().nextDouble() * 256;
      await state.setIdPlayer(idPlayer);
      await score.add({
        'nom-joueur': playerName,
        'point': await getScore(),
        'id-player': idPlayer,
      });
    } else if (idPlayer != 0) {
      QuerySnapshot existingPlayerSnapshot =
          await score.where('id-player', isEqualTo: idPlayer).limit(1).get();

      if (existingPlayerSnapshot.docs.isNotEmpty) {
        await existingPlayerSnapshot.docs.first.reference.update({
          'point': await getScore(),
        });
      }
    }
  }

  Future<void> exit() async {
    state.exit();
  }
}

final providerGame =
    StateNotifierProvider<GameNotifier, Game>((ref) => GameNotifier());
