import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlappyBirdGame(),
    );
  }
}

class FlappyBirdGame extends StatefulWidget {
  @override
  _FlappyBirdGameState createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<FlappyBirdGame> {
  double birdY = 0;
  double time = 0;
  double height = 0.1;
  double velocity = 0;
  double gravity = -6;
  double birdWidth = 0.07;
  double birdHeight = 0.1;
  double pipeWidth = 0.2;
  double pipeGap = 0.7; // Ajout de l'écart entre les tuyaux
  List<List<double>> pipes = [];
  bool gameHasStarted = false;
  bool gameOver = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      if (gameHasStarted && !gameOver) {
        setState(() {
          time += 0.1;
          height = gravity * time * time + velocity * time;
          birdY -= 0.01;

          // Add pipes if needed
          if (pipes.isEmpty || pipes.last[0] < 0.5) {
            double pipeY = Random().nextDouble() * (1 - pipeGap);
            pipes.add([1.0, pipeY]);
          }

          // Move pipes and check for collision
          for (int i = 0; i < pipes.length; i++) {
            pipes[i][0] -= 0.02;
            if (pipes[i][0] < -pipeWidth) {
              pipes.removeAt(i);
              score++;
              i--;
            }
          }

          // Check for collisions
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
      double pipeGapY = pipe[1]; // Position du haut du "gap"
      double gapBottom = pipeGapY + pipeGap; // Position du bas du "gap"

      double pipeLeft = pipeX;
      double pipeRight = pipeLeft + pipeWidth;

      // Vérification des collisions horizontales : L'oiseau est à l'intérieur du tuyau horizontalement
      bool birdInsidePipeHorizontally =
          birdRight > pipeLeft && birdLeft < pipeRight;

      // Vérification des collisions verticales : L'oiseau doit être dans le gap entre les deux tuyaux
      bool birdHitsTopPipe = birdY < pipeGapY; // L'oiseau touche le haut du gap
      bool birdHitsBottomPipe = birdBottom > gapBottom; // L'oiseau touche le bas du gap

      if (birdInsidePipeHorizontally &&
          (birdHitsTopPipe || birdHitsBottomPipe)) {
        gameOver = true;
        gameHasStarted = false;
      }
    }

    // Vérification si l'oiseau touche le sol ou le plafond
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
        birdY = 0.1;
        gameOver = false;
        velocity = 0.5;
        time = 0;
        height = 0.01;
      });
    } else {
      setState(() {
        birdY += 0.1;
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.green,
                      ),
                    ),
                    // Oiseau avec hitbox
                    Positioned(
                      bottom: birdY * MediaQuery.of(context).size.height,
                      left: MediaQuery.of(context).size.width * 0.1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * birdWidth,
                        height: MediaQuery.of(context).size.height * birdHeight,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          border: Border.all(
                              color: Colors.red,
                              width: 2), // Bordure pour hitbox
                        ),
                      ),
                    ),
                    // Tuyaux avec hitbox
                    ...pipes.map((pipe) {
                      return Positioned(
                        bottom: 0,
                        left: pipe[0] * MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * pipeWidth,
                              height:
                                  MediaQuery.of(context).size.height * pipe[1],
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                border: Border.all(
                                    color: Colors.red,
                                    width: 2), // Bordure pour hitbox
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    pipeGap),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * pipeWidth,
                              height: MediaQuery.of(context).size.height *
                                  (1 - pipe[1] - pipeGap),
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                border: Border.all(
                                    color: Colors.red,
                                    width: 2), // Bordure pour hitbox
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    Positioned(
                      top: 50,
                      right: 20,
                      child: Text(
                        'Score: $score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (gameOver)
                      Center(
                        child: Text(
                          'Game Over!',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
