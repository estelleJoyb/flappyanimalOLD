import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Pipe extends SpriteComponent {
  double velocity = -5.0;

  Pipe() {
    size = Vector2(100, 500);
    // Charge l'image du tuyau
  }

  @override
  void update(double dt) {
    super.update(dt);
    x += velocity;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Dessine le tuyau
  }
}
