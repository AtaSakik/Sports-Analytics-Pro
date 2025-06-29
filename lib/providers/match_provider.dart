import 'package:flutter/foundation.dart';
import '../models/match.dart';
import '../models/player.dart';

class MatchProvider with ChangeNotifier {
  final List<Match> _matches = [];
  final List<Player> _players = [
    Player(id: '1', name: 'John Doe', position: 'Forward'),
    Player(id: '2', name: 'Jane Smith', position: 'Midfielder'),
    Player(id: '3', name: 'Robert Brown', position: 'Defender'),
    Player(id: '4', name: 'Emily Johnson', position: 'Goalkeeper'),
  ];

  List<Match> get matches => [..._matches];
  List<Player> get players => [..._players];

  void addMatch(Match newMatch) {
    _matches.add(newMatch);
    notifyListeners();
  }

  void addPlayer(Player player) {
    _players.add(player);
    notifyListeners();
  }

  Player? getPlayerById(String id) {
    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}