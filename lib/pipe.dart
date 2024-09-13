import 'package:flutter/material.dart';

class Pipe extends StatelessWidget {
  final double pipeX;
  final double pipeY;
  final double pipeWidth;
  final double pipeGap;

  Pipe({required this.pipeX, required this.pipeY, required this.pipeWidth, required this.pipeGap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: pipeX * MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * pipeWidth,
            height: MediaQuery.of(context).size.height * (1 - pipeY - pipeGap),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 94, 94, 95),
              border: Border.all(
                  color: Colors.red,
                  width: 2), // Bordure pour hitbox
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * pipeGap),
          Container(
            width: MediaQuery.of(context).size.width * pipeWidth,
            height: MediaQuery.of(context).size.height * pipeY,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 92, 90, 90),
              border: Border.all(
                  color: Colors.red,
                  width: 2), // Bordure pour hitbox
            ),
          ),
        ],
      ),
    );
  }
}
