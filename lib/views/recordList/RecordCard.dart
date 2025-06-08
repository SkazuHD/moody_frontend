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
  }

  @override
  void dispose() {
    super.dispose();
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
              StreamBuilder(
                stream: audioService.isThisCurrentlyPlaying(recording),
                builder: (context, asyncSnapshot) {
                  final isPlaying = asyncSnapshot.data ?? false;
                  return AudioControls(
                    isPlaying: isPlaying,
                    showSeekBar: true,
                    trackProgress: audioService.trackProgressFor(recording),
                    onPlay: () async {
                      log("On Play pressed");
                      await audioService.play(recording);
                    },
                    onPause: () async {
                      log("On Pause pressed");
                      await audioService.pause();
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
