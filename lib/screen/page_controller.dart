import 'package:flutter/material.dart';
import 'package:flappyanimal/screen/page_menu.dart';
import 'package:flappyanimal/screen/page_game.dart';
import 'package:flappyanimal/screen/page_scores.dart';

class PagesController extends StatefulWidget {
  const PagesController({Key? key}) : super(key: key);

  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  void goBestScores() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScoreScreen(goExit, goMenu, goPlay)));
  }

  void goPlay() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GameScreen(goExit, goMenu, goBestScores)));
  }

  void goMenu() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MenuScreen(goExit, goPlay, goBestScores)));
  }

  void goExit() {
    Navigator.pop(context);
    goMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MenuScreen(goExit, goPlay, goBestScores));
  }
}
