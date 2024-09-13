import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flappyanimal/provider/flappyanimal_provider.dart';

class ScoreScreen extends ConsumerWidget {
  final void Function() goExit;
  final void Function() goMenu;
  final void Function() goPlay;

  const ScoreScreen(
    this.goExit,
    this.goMenu,
    this.goPlay, {
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
                'Scores',
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
                    goMenu();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  child: const Text('Retour au menu')),
            ],
          ),
        ),
      ),
    );
  }
}
