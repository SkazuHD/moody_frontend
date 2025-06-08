import 'dart:developer';

import 'package:Soullog/components/AudioControlComponents.dart';
import 'package:flutter/material.dart';

import '../../data/constants/emotions.dart';
import '../../data/models/record.dart';
import '../../helper/dateHelper.dart';
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
    log("RecordCard initialized with recording ID: ${widget.recording.id}");
  }

  @override
  Widget build(BuildContext context) {
    final recording = widget.recording;
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(color: getEmotionColor(recording.mood), borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          trailing: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(getEmotionEmoji(recording.mood), style: TextStyle(fontSize: 24)),
          ),
          title: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: audioService.isCurrentlyPlaying,
                builder: (context, recordID, child) {
                  return AudioControls(
                    isPlaying: recordID == recording.id,
                    onPlay: () async {
                      log("On Play pressed with ID: ${recording.id}");
                      await audioService.setSource(recording.filePath!);
                      await audioService.playAudio(recording);
                    },
                    onPause: () async {
                      log("On Pause pressed");
                      await audioService.pauseAudio();
                    },
                  );
                },
              ),
            ],
          ),
          subtitle: Text(
            '${recording.mood} ${getFullDate(recording.createdAt)}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
