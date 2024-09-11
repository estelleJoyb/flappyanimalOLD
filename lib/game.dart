import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'bird.dart';
import 'pipe.dart';

class GameWidget extends FlameGame {
  late Bird bird;
  late List<Pipe> pipes;

  @override
  Future<void> onLoad() async {
    bird = Bird();
    pipes = [Pipe()];
    add(bird);
    pipes.forEach(add);
  }

  @override
  void update(double dt) {
    super.update(dt);
    bird.update(dt);
    for (var pipe in pipes) {
      pipe.update(dt);
    }
    // Ajoute la logique pour vérifier les collisions et déplacer les tuyaux
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    bird.render(canvas);
    for (var pipe in pipes) {
      pipe.render(canvas);
    }
  }

  void onTap() {
    bird.jump();
  }
}
