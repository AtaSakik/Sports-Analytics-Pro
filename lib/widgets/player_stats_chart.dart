import 'package:flutter/material.dart';
import '../models/stats.dart';
import '../models/player.dart';

class PlayerStatsChart extends StatelessWidget {
  final Player player;
  final PlayerStats stats;

  const PlayerStatsChart({
    super.key,
    required this.player,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final statItems = _getStatItems();
    final maxValue = _getMaxValue(statItems);

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statItems.length,
        itemBuilder: (context, index) {
          return _buildStatBar(statItems[index], maxValue, context);
        },
      ),
    );
  }

  List<StatItem> _getStatItems() {
    return [
      StatItem('Goals', stats.goals, Colors.green),
      StatItem('Assists', stats.assists, Colors.blue),
      StatItem('Passes', stats.passes, Colors.orange),
      StatItem('Tackles', stats.tackles, Colors.red),
      if (player.position == 'Goalkeeper')
        StatItem('Saves', stats.saves, Colors.purple),
    ];
  }

  int _getMaxValue(List<StatItem> items) {
    return items.fold(0, (max, item) => item.value > max ? item.value : max);
  }

  Widget _buildStatBar(StatItem item, int maxValue, BuildContext context) {
    final heightFactor = maxValue > 0 ? item.value / maxValue : 0.1;
    final barHeight = MediaQuery.of(context).size.height * 0.15 * heightFactor;

    return Container(
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            item.value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            height: barHeight,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class StatItem {
  final String label;
  final int value;
  final Color color;

  StatItem(this.label, this.value, this.color);
}