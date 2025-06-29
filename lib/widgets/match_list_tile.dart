import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchListTile extends StatelessWidget {
  final Match match;

  const MatchListTile({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text('${match.teamA} vs ${match.teamB}'),
        subtitle: Text(match.formattedDate),
        trailing: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('${match.scoreA} - ${match.scoreB}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}