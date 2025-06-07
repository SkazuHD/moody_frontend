import 'package:flutter/material.dart';

import '../../data/constants/emotions.dart';
import '../../data/models/record.dart';

class RecordCard extends StatelessWidget {
  final Recording recording;

  const RecordCard({super.key, required this.recording});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(color: getEmotionColor(recording.mood), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: Text(
            recording.transcription ?? '',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${recording.mood} ${recording.createdAt.toLocal().toIso8601String()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
