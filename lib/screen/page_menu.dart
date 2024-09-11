import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flappyanimal/provider/flappyanimal_provider.dart';

class MenuScreen extends ConsumerWidget {
  final void Function() goExit;
  final void Function() goPlay;
  final void Function() goBestScores;

  const MenuScreen(
    this.goExit,
    this.goPlay,
    this.goBestScores, {
    super.key,
  });
  //pour utiliser le provider : ref.watch(providerDemo.notifier).setErreur("truc");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Flappy Animals',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    goPlay();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text('Jouer')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  goBestScores();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Meilleurs Scores'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  goExit();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Quitter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//   import 'package:flutter/material.dart';

// class MainMenu extends StatelessWidget {
//   const MainMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('background.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Flappy Animals',
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 10.0,
//                       color: Colors.black,
//                       offset: Offset(5.0, 5.0),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 50),
//               ElevatedButton(
//                 child: Text('Jouer'),
//                 onPressed: () {
//                   // Naviguer vers l'écran de jeu
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text('Meilleurs Scores'),
//                 onPressed: () {
//                   // Naviguer vers l'écran des meilleurs scores
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text('Quitter'),
//                 onPressed: () {
//                   // Quitter l'application
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }