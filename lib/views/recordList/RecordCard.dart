import 'package:Soullog/views/record/record.dart';
import 'package:flutter/material.dart';

import '../../components/AudioControlComponents.dart';
import '../../data/constants/emotions.dart';
import '../../data/models/record.dart';
import '../../services/audio-service.dart';

class RecordCard extends StatefulWidget {
  final Recording recording;

  const RecordCard({super.key, required this.recording});

  @override
  State<RecordCard> createState() => _RecordCardState();
}

class _RecordCardState extends State<RecordCard> {
  final audioService = AudioService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: getEmotionColor(widget.recording.mood),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: Row(children: [ControlButtons(audioService, recording, showSeekBar: true)]),
          subtitle: Text(
            '${widget.recording.mood} ${widget.recording.createdAt.toLocal().toIso8601String()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
