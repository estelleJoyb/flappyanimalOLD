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
  double pipeHeight = 0.6;
  List<List<double>> pipes = [];
  bool gameHasStarted = false;
  bool gameOver = false;
  int score = 0;
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      print("periodic");
      if (gameHasStarted && !gameOver) {
        setState(() {
          time += 0.1;
          height = gravity * time * time + velocity * time;
          birdY = max(0, min(1 - birdHeight, birdY - height));

          // Add pipes if needed
          if (pipes.isEmpty || pipes.last[0] < 0.5) {
            double pipeY = Random().nextDouble() * (1 - pipeHeight - 0.2);
            pipes.add([1.0, pipeY]);
          }

          // Move pipes and check for collision
          for (int i = 0; i < pipes.length; i++) {
            pipes[i][0] -= 0.02;
            if (pipes[i][0] < -pipeWidth) {
              pipes.removeAt(i);
              score++;
              i--;
            } else {
              if (pipes[i][0] < 0.1 + birdWidth && pipes[i][0] + pipeWidth > 0.1) {
                if (birdY < pipes[i][1] || birdY + birdHeight > pipes[i][1] + pipeHeight) {
                  gameOver = true;
                  gameHasStarted = false;
                }
              }
            }
          }

          // Check if the bird hits the ground or ceiling
          if (birdY <= 0 || birdY >= 1 - birdHeight) {
            gameOver = true;
            gameHasStarted = false;
          }
        });
      }
    });
  }
  
  void jump() {
    if (!gameHasStarted) {
      setState(() {
        gameHasStarted = true;
        pipes = [];
        score = 0;
        birdY = 0.1;
        gameOver = false;
        velocity = 0.3;
        time = 0;
        height= 0.01;
        print("coucou");
      });
    }else{
      setState(() {
        birdY += 0.1;
        print("mon reuf");
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
                    Positioned(
                      bottom: birdY * MediaQuery.of(context).size.height,
                      left: MediaQuery.of(context).size.width * 0.1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * birdWidth,
                        height: MediaQuery.of(context).size.height * birdHeight,
                        color: Colors.yellow,
                      ),
                    ),
                    ...pipes.map((pipe) {
                      return Positioned(
                        bottom: 0,
                        left: pipe[0] * MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * pipeWidth,
                              height: MediaQuery.of(context).size.height * pipe[1],
                              color: Colors.brown,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * (1 - pipe[1] - pipeHeight)),
                            Container(
                              width: MediaQuery.of(context).size.width * pipeWidth,
                              height: MediaQuery.of(context).size.height * pipeHeight,
                              color: Colors.brown,
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
