import 'package:flutter/material.dart';

class ScrollingBackground extends StatefulWidget {
  final String imagePath;
  final bool isGameOver;

  ScrollingBackground({required this.imagePath, required this.isGameOver});

  @override
  _ScrollingBackgroundState createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Durée de l'animation
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(ScrollingBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isGameOver) {
      _controller.stop(); // Arrête l'animation si le jeu est terminé
    } else {
      _controller.repeat(); // Redémarre l'animation si le jeu est en cours
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              left: -_animation.value * MediaQuery.of(context).size.width,
              bottom: 0,
              child: Image.asset(
                widget.imagePath,
                width: MediaQuery.of(context).size.width * 1, // Double largeur pour le défilement
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width - (_animation.value * MediaQuery.of(context).size.width),
              bottom: 0,
              child: Image.asset(
                widget.imagePath,
                width: MediaQuery.of(context).size.width * 1, // Double largeur pour le défilement
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}