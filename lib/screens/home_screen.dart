import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analytics_screen.dart';
import 'match_add_screen.dart';
import 'match_detail_screen.dart';
import '../widgets/match_list_tile.dart';
import '../providers/match_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports Analytics Pro'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.sports_soccer), text: 'Matches'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MatchListScreen(),
          AnalyticsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MatchAddScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final matches = matchProvider.matches;

    return matches.isEmpty
        ? const Center(child: Text('No matches recorded'))
        : ListView.builder(
      itemCount: matches.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MatchDetailScreen(match: matches[i]),
          ),
        ),
        child: MatchListTile(match: matches[i]),
      ),
    );
  }
}