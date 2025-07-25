import 'package:flutter/material.dart';
import 'package:screen_record_app/services/local_storage/local_storage.dart';

import '../../../model/entities/local_game_model.dart';


class LocalGameListScreen extends StatefulWidget {
  const LocalGameListScreen({super.key});

  @override
  State<LocalGameListScreen> createState() => _LocalGameListScreenState();
}

class _LocalGameListScreenState extends State<LocalGameListScreen> {
  List<LocalGameModel> games = [];

  @override
  void initState() {
    super.initState();
    games = LocalStorage().getSavedGames();
  }

  void _deleteGame(String id) async {
    await LocalStorage().deleteGameLocally(id);
    setState(() {
      games = LocalStorage().getSavedGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Games")),
      body: ListView.separated(
        itemCount: games.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final game = games[index];
          return Container(
            color: index == 0 ? Colors.grey[300] : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: Text(game.id)),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('vs. ${game.visitorTeamID}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${game.gameDate} @ ${game.gameStartTime}'),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("0 events", style: TextStyle(fontSize: 12)),
                    Text("The video has no uploaded files, or no URL.", style: TextStyle(fontSize: 11, color: Colors.red)),
                  ],
                )),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle video action here
                  },
                  icon: const Icon(Icons.ondemand_video),
                  label: const Text("Video"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      // Navigate to edit screen
                    } else if (value == 'replace') {
                      // Implement replace video logic
                    } else if (value == 'delete') {
                      _deleteGame(game.id);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit Game Info')),
                    const PopupMenuItem(value: 'replace', child: Text('Replace Video')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete Game')),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text("More..", style: TextStyle(color: Colors.orange)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
