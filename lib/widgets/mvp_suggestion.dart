import 'package:flutter/material.dart';
import '../utils/mvp_logic.dart';
import '../models/match.dart';
import '../models/player.dart';

class MvpSuggestion extends StatelessWidget {
  final Match match;
  final Player Function(String) getPlayer;

  const MvpSuggestion({
    super.key,
    required this.match,
    required this.getPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final mvpName = MvpLogic.suggestMvp(
      match.playerStats,
      getPlayer,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Player of the Match', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(mvpName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('AI suggestion', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}