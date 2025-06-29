import 'package:flutter/material.dart';
import '../models/player.dart';

class AnalyticsSummary extends StatelessWidget {
  final String title;
  final Player player;
  final String value;
  final Color color;

  const AnalyticsSummary({
    super.key,
    required this.title,
    required this.player,
    required this.value,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            )),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.2),
                  ),
                  child: Icon(Icons.emoji_events, color: color),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(player.name, style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    )),
                    Text(player.position, style: TextStyle(
                        color: Colors.grey[600]
                    )),
                  ],
                ),
                const Spacer(),
                Text(value, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}