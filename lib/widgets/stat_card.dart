import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(
                fontSize: 16,
                color: Colors.blue[800]
            )),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
    );
  }
}