import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../models/player.dart';
import '../models/stats.dart';
import '../providers/match_provider.dart';

class MatchAddScreen extends StatefulWidget {
  const MatchAddScreen({super.key});

  @override
  _MatchAddScreenState createState() => _MatchAddScreenState();
}

class _MatchAddScreenState extends State<MatchAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _scoreAController = TextEditingController(text: '0');
  final _scoreBController = TextEditingController(text: '0');
  final Map<String, PlayerStats> _playerStats = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _initializePlayerStats();
  }

  void _initializePlayerStats() {
    final players = Provider.of<MatchProvider>(context, listen: false).players;
    for (var player in players) {
      _playerStats[player.id] = PlayerStats(playerId: player.id);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveMatch() {
    if (_formKey.currentState!.validate()) {
      final newMatch = Match(
        id: DateTime.now().toString(),
        date: _selectedDate,
        teamA: _teamAController.text,
        teamB: _teamBController.text,
        scoreA: int.parse(_scoreAController.text),
        scoreB: int.parse(_scoreBController.text),
        playerStats: _playerStats,
      );

      Provider.of<MatchProvider>(context, listen: false).addMatch(newMatch);
      Navigator.pop(context);
    }
  }

  void _updatePlayerStat(String playerId, String statType, int value) {
    setState(() {
      switch (statType) {
        case 'goals':
          _playerStats[playerId]!.goals = value;
          break;
        case 'assists':
          _playerStats[playerId]!.assists = value;
          break;
        case 'passes':
          _playerStats[playerId]!.passes = value;
          break;
        case 'tackles':
          _playerStats[playerId]!.tackles = value;
          break;
        case 'saves':
          _playerStats[playerId]!.saves = value;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<MatchProvider>(context).players;

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Match')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _teamAController,
              decoration: const InputDecoration(labelText: 'Team A'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            TextFormField(
              controller: _teamBController,
              decoration: const InputDecoration(labelText: 'Team B'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _scoreAController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Team A Score'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _scoreBController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Team B Score'),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(DateFormat.yMMMd().format(_selectedDate)),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Change date'),
                ),
              ],
            ),
            const Divider(height: 30),

            const Text('Player Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...players.map((player) => _PlayerStatForm(
              player: player,
              stats: _playerStats[player.id]!,
              onUpdate: _updatePlayerStat,
            )).toList(),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveMatch,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Match'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerStatForm extends StatelessWidget {
  final Player player;
  final PlayerStats stats;
  final Function(String, String, int) onUpdate;

  const _PlayerStatForm({
    required this.player,
    required this.stats,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                _StatInput(
                  label: 'Goals',
                  value: stats.goals,
                  onChanged: (value) => onUpdate(player.id, 'goals', value),
                ),
                const SizedBox(width: 16),
                _StatInput(
                  label: 'Assists',
                  value: stats.assists,
                  onChanged: (value) => onUpdate(player.id, 'assists', value),
                ),
                const SizedBox(width: 16),
                _StatInput(
                  label: 'Tackles',
                  value: stats.tackles,
                  onChanged: (value) => onUpdate(player.id, 'tackles', value),
                ),
              ],
            ),
            if (player.position == 'Goalkeeper')
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    _StatInput(
                      label: 'Saves',
                      value: stats.saves,
                      onChanged: (value) => onUpdate(player.id, 'saves', value),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _StatInput extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onChanged;

  const _StatInput({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
                iconSize: 20,
              ),
              Text('$value', style: const TextStyle(fontSize: 18)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onChanged(value + 1),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}