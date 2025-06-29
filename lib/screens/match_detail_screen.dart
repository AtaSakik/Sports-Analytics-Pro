import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../widgets/player_stats_chart.dart';
import '../widgets/mvp_suggestion.dart';
import '../providers/match_provider.dart';

class MatchDetailScreen extends StatelessWidget {
  final Match match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('${match.teamA} vs ${match.teamB}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Match summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(match.teamA, style: const TextStyle(fontSize: 24)),
                Text('${match.scoreA} - ${match.scoreB}',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                Text(match.teamB, style: const TextStyle(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 10),
            Center(child: Text(match.formattedDate, style: const TextStyle(color: Colors.grey))),
            const Divider(height: 30),

            // MVP suggestion
            MvpSuggestion(
              match: match,
              getPlayer: (id) => matchProvider.getPlayerById(id)!,
            ),
            const SizedBox(height: 20),

            // Player stats
            const Text('Player Statistics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...match.playerStats.entries.map((entry) {
              final player = matchProvider.getPlayerById(entry.key);
              return player == null
                  ? const SizedBox()
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(player.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                  PlayerStatsChart(player: player, stats: entry.value),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}