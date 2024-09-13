import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/modele/game.dart';

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

  //getters
  bool getGamehasstarted() {
    return state.gameHasStarted;
  }

  bool getGameOver() {
    return state.gameOver;
  }

  int getScore() {
    return state.score;
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

  // actions
  void checkCollisions() {
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
    print("jump !! game has started ${state.gameHasStarted}");
    Game newGame = state.cloneGame();
    if (!newGame.gameHasStarted) {
      newGame.gameHasStarted = true;
      newGame.pipes = [];
      newGame.score = 0;
      newGame.birdY = 0;
      newGame.gameOver = false;
      newGame.velocityX = 0.01;
      newGame.time = 0;
    } else {
      print("velocity !! ${newGame.velocityY}");
      newGame.velocityY = -0.035;
    }
    state = newGame;
  }

  void initGame() {
    print("init game !!");
    Game newGame = state.cloneGame();
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (newGame.gameHasStarted && !newGame.gameOver) {
        newGame.time += 0.1;
        if (newGame.velocityY < 0) {
          newGame.velocityY += newGame.gravity * 10;
        } else {
          newGame.velocityY -= newGame.velocityY;
        }
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
        checkCollisions();
      }
    });
    state = newGame;
  }
}

final providerGame =
    StateNotifierProvider<GameNotifier, Game>((ref) => GameNotifier());
