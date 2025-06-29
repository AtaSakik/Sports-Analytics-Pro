import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../models/player.dart';
import '../providers/match_provider.dart';
import '../widgets/analytics_summary.dart';
import '../widgets/stat_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final matches = matchProvider.matches;
    final players = matchProvider.players;

    // Calculate total goals
    int totalGoals = matches.fold(0, (sum, match) => sum + match.scoreA + match.scoreB);

    // Find top scorer
    Map<String, int> playerGoals = {};
    for (var match in matches) {
      for (var stat in match.playerStats.values) {
        playerGoals.update(stat.playerId, (value) => value + stat.goals,
            ifAbsent: () => stat.goals);
      }
    }

    Player? topScorer;
    int maxGoals = 0;
    playerGoals.forEach((playerId, goals) {
      if (goals > maxGoals) {
        maxGoals = goals;
        topScorer = matchProvider.getPlayerById(playerId);
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performance Insights',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // Summary cards
          Row(
            children: [
              StatCard(title: 'Total Matches', value: matches.length.toString()),
              const SizedBox(width: 10),
              StatCard(title: 'Total Goals', value: totalGoals.toString()),
            ],
          ),
          const SizedBox(height: 20),

          // Top performer
          if (topScorer != null)
            AnalyticsSummary(
              title: 'Top Scorer',
              player: topScorer!,
              value: '$maxGoals goals',
              color: Colors.amber,
            ),
        ],
      ),
    );
  }
}