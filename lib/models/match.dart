import 'package:intl/intl.dart';
import 'stats.dart';

class Match {
  final String id;
  final DateTime date;
  final String teamA;
  final String teamB;
  final int scoreA;
  final int scoreB;
  final Map<String, PlayerStats> playerStats;

  Match({
    required this.id,
    required this.date,
    required this.teamA,
    required this.teamB,
    required this.scoreA,
    required this.scoreB,
    required this.playerStats,
  });

  String get formattedDate => DateFormat('dd MMM yyyy').format(date);
}