import 'dart:collection';
import 'dart:convert';

import 'package:flappyanimal/components/bird_component.dart';
import 'package:flappyanimal/components/gameover_component.dart';
import 'package:flappyanimal/components/pipe_component.dart';
import 'package:flappyanimal/components/scrolling_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappyanimal/provider/game_provider.dart';

class GameScreen extends ConsumerWidget {
  final void Function() goExit;
  final void Function() goMenu;
  final void Function() goBestScores;

  const GameScreen(
    this.goExit,
    this.goMenu,
    this.goBestScores, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier =
        ref.read(providerGame.notifier); // Use read for actions
    final gameState = ref.watch(providerGame); // Use watch to observe state

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (!gameState.gameHasStarted) {
                  gameNotifier.initGame();
                }
                gameNotifier.jump();
              },
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
                        imagePath: 'assets/game_background.png', isGameOver: gameState.gameOver,),
                      ),
                    ),
                    Bird(
                      birdY: gameState.birdY,
                      birdHeight: gameState.birdHeight,
                      birdWidth: gameState.birdWidth,
                    ),
                    ...gameState.pipes.map((pipe) {
                      return Pipe(
                        pipeX: pipe[0],
                        pipeY: pipe[1],
                        pipeWidth: gameState.pipeWidth,
                        pipeGap: gameState.pipeGap,
                      );
                    }).toList(),
                    Positioned(
                      top: 50,
                      right: 20,
                      child: Text(
                        'Score: ${gameState.score}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    if (gameState.gameOver) const GameOverScreen(),
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
