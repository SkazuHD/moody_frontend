import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double iconSize;

  const NoDataView({
    super.key,
    this.title = 'No mood data available',
    this.subtitle = 'Start with your first entry!',
    this.icon = Icons.sentiment_dissatisfied,
    this.color = Colors.grey,
    this.iconSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(fontSize: 14, color: color), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
