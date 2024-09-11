import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteComponent {
  double velocity = 0.0;

  Bird() {
    size = Vector2(50, 50);
    // Charge l'image de l'oiseau
  }

  void jump() {
    velocity = -10.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity += 0.5; // Gravité
    y += velocity;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Dessine l'oiseau
  }
}
