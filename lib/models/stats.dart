class PlayerStats {
  final String playerId;
  int goals;
  int assists;
  int passes;
  int tackles;
  int saves; // For goalkeepers
  double rating;

  PlayerStats({
    required this.playerId,
    this.goals = 0,
    this.assists = 0,
    this.passes = 0,
    this.tackles = 0,
    this.saves = 0,
    this.rating = 6.0,
  });
}