import 'package:flappyanimal/provider/game_provider.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final void Function() goMenu;
  final int score;

  const GameOverScreen(this.goMenu, this.score, {super.key});

  Future<void> showNameDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your name'),
          content: TextField(
            maxLength: 12,
            controller: nameController,
            decoration: const InputDecoration(hintText: "Your name"),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(nameController.text);
              },
            ),
          ],
        );
      },
    );
    String playerName = nameController.text;
    if (playerName.isNotEmpty) {
      GameNotifier().setScore(score);
      await GameNotifier().savePlayerScore(playerName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
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
            onPressed: () async {
              double? idPlayer = await GameNotifier().getIdPlayer();
              if (idPlayer == 0) {
                // ignore: use_build_context_synchronously
                await showNameDialog(context);
              } else {
                GameNotifier().setScore(score);
                await GameNotifier().savePlayerScore();
              }
            },
            child: const Text('Save Score'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              goMenu();
            },
            child: const Text('Back to Menu'),
          ),
        ],
      ),
    );
  }
}
