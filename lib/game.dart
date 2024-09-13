import 'package:flappyanimal/scrolling_background.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'bird.dart';
import 'pipe.dart';
import 'game_over.dart';

class FlappyBirdGame extends StatefulWidget {
  @override
  _FlappyBirdGameState createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<FlappyBirdGame> {
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

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (gameHasStarted && !gameOver) {
        setState(() {
          time += 0.1;
          if (velocityY < 0) {
            velocityY += gravity * 10;
          } else {
            velocityY = min(0.012, velocityY + gravity);
          }
          birdY -= velocityY;

          if (pipes.isEmpty || pipes.last[0] < 0.2) {
            double pipeY = Random().nextDouble() * (1 - pipeGap);
            pipes.add([1.0, pipeY]);
          }

          for (int i = 0; i < pipes.length; i++) {
            pipes[i][0] -= velocityX;
            if (pipes[i][0] < -pipeWidth) {
              pipes.removeAt(i);
              score++;
              i--;
            }
          }

          _checkCollisions();
        });
      }
    });
  }

  void _checkCollisions() {
    double birdBottom = birdY + birdHeight;
    double birdLeft = 0.1;
    double birdRight = birdLeft + birdWidth;

    for (var pipe in pipes) {
      double pipeX = pipe[0];
      double pipeGapY = pipe[1];
      double gapBottom = pipeGapY + pipeGap;

      double pipeLeft = pipeX;
      double pipeRight = pipeLeft + pipeWidth;

      bool birdInsidePipeHorizontally =
          birdRight > pipeLeft && birdLeft < pipeRight;

      bool birdHitsTopPipe = birdY < pipeGapY;
      bool birdHitsBottomPipe = birdBottom > gapBottom;

      if (birdInsidePipeHorizontally &&
          (birdHitsTopPipe || birdHitsBottomPipe)) {
        gameOver = true;
        gameHasStarted = false;
      }
    }

    if (birdY <= 0 || birdY + birdHeight >= 1) {
      gameOver = true;
      gameHasStarted = false;
    }
  }

  void jump() {
    if (!gameHasStarted) {
      setState(() {
        gameHasStarted = true;
        pipes = [];
        score = 0;
        birdY = 0.5;
        gameOver = false;
        velocityX = 0.01;
        time = 0;
      });
    } else {
      setState(() {
        velocityY = -0.035;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: jump,
              child: Container(
                color: Colors.blue,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ScrollingBackground(
                        imagePath: 'assets/images/backgrounds/background2.png', isGameOver: gameOver,),
                      ),
                    ),
                    Bird(birdY: birdY, birdHeight: birdHeight, birdWidth: birdWidth),
                    ...pipes.map((pipe) {
                      return Pipe(pipeX: pipe[0], pipeY: pipe[1], pipeWidth: pipeWidth, pipeGap: pipeGap);
                    }).toList(),
                    Positioned(
                      top: 50,
                      right: 20,
                      child: Text(
                        'Score: $score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (gameOver)
                      GameOverScreen(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
