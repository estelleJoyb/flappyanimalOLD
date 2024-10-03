import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappyanimal/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider<String?>((ref) => null);

class ScoreScreen extends ConsumerWidget {
  final void Function() goExit;
  final void Function() goMenu;
  final void Function() goPlay;
  double idPlayer = 0;
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
    String? fetchedUserName =
        await GameNotifier().getUserNameFromIdPlayer(idPlayer);

    ref.read(userNameProvider.notifier).state = fetchedUserName;

    print("name $fetchedUserName");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init(context, ref);
    });

    String? userName = ref.watch(userNameProvider);

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
                'Best Scores',
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
              ElevatedButton(
                onPressed: () {
                  goMenu();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text('Back to Menu'),
              ),
              const SizedBox(height: 10),
              Text(userName ?? ""),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                child: StreamBuilder(
                  stream: score.orderBy('point', descending: true).snapshots(),
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
                              '${data['nom-joueur']} : ${data['point']}',
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
