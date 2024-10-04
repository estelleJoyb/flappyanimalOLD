import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappyanimal/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider<String?>((ref) => null);
final currentPlayerScoreProvider = StateProvider<int>((ref) => 0);

class ScoreScreen extends ConsumerWidget {
  final void Function() goExit;
  final void Function() goMenu;
  final void Function() goPlay;
  double idPlayer = 0;
  int currentPlayerScore = 0;
  late final CollectionReference score =
      FirebaseFirestore.instance.collection('score');

  ScoreScreen(
    this.goExit,
    this.goMenu,
    this.goPlay, {
    super.key,
  });

  Future<void> init(BuildContext context, WidgetRef ref) async {
    idPlayer = await GameNotifier().getIdPlayer();
    currentPlayerScore = await GameNotifier().getScore();
    String? fetchedUserName =
        await GameNotifier().getUserNameFromIdPlayer(idPlayer);
    ref.read(userNameProvider.notifier).state = fetchedUserName;
    ref.read(currentPlayerScoreProvider.notifier).state = currentPlayerScore;
  }

  Future<void> updateUserName(BuildContext context, WidgetRef ref) async {
    String? newUserName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String tempUserName = "";
        return AlertDialog(
          title: const Text('Modifier le nom d\'utilisateur'),
          content: TextField(
            onChanged: (value) {
              tempUserName = value;
            },
            decoration:
                const InputDecoration(hintText: "Entrez le nouveau nom"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop(tempUserName);
              },
            ),
          ],
        );
      },
    );

    if (newUserName != null && newUserName.isNotEmpty) {
      await GameNotifier().changeUserName(idPlayer, newUserName);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        init(context, ref);
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init(context, ref);
    });

    String? userName = ref.watch(userNameProvider);
    int currentPlayerScore = ref.watch(currentPlayerScoreProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
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
                'Top 10 Best Scores',
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: <Widget>[
                      Text(
                        userName != null
                            ? "$userName Best Score is ${currentPlayerScore}pts"
                            : "",
                        style: TextStyle(
                          fontSize: 20,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Colors.lightBlue,
                        ),
                      ),
                      Text(
                        userName != null
                            ? "$userName Best Score is ${currentPlayerScore}pts"
                            : "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  userName != null
                      ? IconButton(
                          tooltip: "Change username",
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => updateUserName(context, ref),
                        )
                      : const SizedBox(width: 0),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                child: StreamBuilder(
                  stream: score
                      .orderBy('point', descending: true)
                      .limit(10)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Material(
                          type: MaterialType.transparency,
                          child: ListTile(
                            tileColor: Colors.cyan[50],
                            title: Text(
                              '${data['nom-joueur']} : ${data['point']}pts',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
