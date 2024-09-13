import 'dart:math';

import 'package:flappyanimal/provider/game_provider.dart';
import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  final double pipeX;
  final double pipeY;
  final double pipeWidth;
  final double pipeGap;

  Pipe(
      {required this.pipeX,
      required this.pipeY,
      required this.pipeWidth,
      required this.pipeGap});

  @override
  Widget build(BuildContext context) {
    const pipeImage = 'assets/pipe.png';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: 0,
      left: pipeX * screenWidth,
      child: Column(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(pi),
            // Partie supérieure du tuyau (qui vient du haut)
            child: Container(
              width: screenWidth * pipeWidth,
              height: screenHeight * (1 - pipeY - pipeGap),
              child: Image.asset(
                pipeImage,
                width: screenWidth * pipeWidth,
                height: screenHeight * (1 - pipeY - pipeGap),
                fit: BoxFit.fill,
                alignment: Alignment
                    .bottomCenter, // Aligne l'image vers le bas pour la continuité
              ),
            ),
          ),
          // Espace vide correspondant au "gap" entre les tuyaux
          SizedBox(height: screenHeight * pipeGap),
          // Partie inférieure du tuyau (qui vient du bas)
          // Rotation à 180 degrés pour le tuyau du bas
          Container(
            width: screenWidth * pipeWidth,
            height: screenHeight * pipeY,
            child: Image.asset(
              pipeImage,
              width: screenWidth * pipeWidth,
              height: screenHeight * pipeY,
              fit: BoxFit.fill,
              alignment: Alignment
                  .topCenter, // Aligne l'image vers le haut pour la continuité
            ),
          ),
        ],
      ),
    );
  }
}
