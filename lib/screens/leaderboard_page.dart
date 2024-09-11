import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData = [
    {"rank": 1, "name": "Joueur 1", "score": 100},
    {"rank": 2, "name": "Joueur 2", "score": 95},
    {"rank": 3, "name": "Joueur 3", "score": 90},
    {"rank": 4, "name": "Joueur 4", "score": 85},
    {"rank": 5, "name": "Joueur 5", "score": 80},
  ];

  LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meilleurs Scores'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Classement',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final item = leaderboardData[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.white.withOpacity(0.8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getRankColor(item['rank']),
                        child: Text('${item['rank']}'),
                      ),
                      title: Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text('${item['score']} pts', style: TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text('Retour au Menu'),
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.grey[300]!;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}