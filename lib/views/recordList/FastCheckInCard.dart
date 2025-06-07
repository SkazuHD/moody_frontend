import 'package:Soullog/data/models/record.dart';
import 'package:flutter/material.dart';

import '../../data/constants/emotions.dart';

class FastCheckInCard extends StatelessWidget {
  final Recording recording;

  const FastCheckInCard({super.key, required this.recording});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(color: getEmotionColor(recording.mood), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: Text('Fast Check In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(
            '${recording.mood} ${recording.createdAt.toLocal().toIso8601String()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
