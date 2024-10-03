import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final void Function() goMenu;
  const GameOverScreen(this.goMenu, {super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     //mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text(
  //         'Game Over!',
  //         style: TextStyle(
  //             color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
  //       ),
  //       const Text(
  //         'Tap to play again',
  //         style: TextStyle(
  //             color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
  //       ),
  //       ElevatedButton(
  //         onPressed: () {
  //           goMenu();
  //         },
  //         child: const Text('Retour au menu'),
  //       ),
  //     ],
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return const Center(
  //     child: Text(
  //       'Game Over!',
  //       style: TextStyle(
  //           color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Game Over!',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.lightBlue,
                ),
              ),
              const Text(
                'Game Over!',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Text(
                'Tap to play again!',
                style: TextStyle(
                  fontSize: 25,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.lightBlue,
                ),
              ),
              const Text(
                'Tap to play again!',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              goMenu();
            },
            child: const Text('Retour au menu'),
          ),
        ],
      ),
    );
  }
}
