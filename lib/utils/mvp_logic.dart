import '../models/stats.dart';
import '../models/player.dart';


  class MvpLogic {
  static String suggestMvp(Map<String, PlayerStats> stats, Player Function(String) getPlayer) {
  if (stats.isEmpty) return "No data";

  String mvpId = '';
  double highestScore = 0;

  stats.forEach((playerId, stat) {
  // Position-based scoring system
  double positionMultiplier = 1.0;
  final player = getPlayer(playerId);

  if (player.position == 'Forward') {
  positionMultiplier = 1.2;
  } else if (player.position == 'Goalkeeper') {
  positionMultiplier = 1.1;
  }

  // Calculate weighted score
  final score = (stat.goals * 3 +
  stat.assists * 2 +
  stat.tackles * 1.5 +
  stat.passes * 0.1 +
  stat.saves * 2) *
  positionMultiplier *
  stat.rating;

  if (score > highestScore) {
  highestScore = score;
  mvpId = playerId;
  }
  });

  return mvpId.isNotEmpty ? getPlayer(mvpId).name : "Not determined";
  }
  }