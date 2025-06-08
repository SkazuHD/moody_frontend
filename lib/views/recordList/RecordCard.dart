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
  bool isCurrentlyPlaying = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioService.currentMedia.addListener(() {
      if (audioService.currentMedia.value == widget.recording.id) {
        setState(() {
          isCurrentlyPlaying = true;
        });
      } else {
        setState(() {
          isCurrentlyPlaying = false;
        });
      }
    });
    audioService.isPlaying.addListener(() {
      if (audioService.isPlaying.value) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
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
              AudioControls(
                isPlaying: isPlaying && isCurrentlyPlaying,
                showSeekBar: isCurrentlyPlaying,
                onPlay: () async {
                  log("On Play pressed with ID: ${recording.id}");
                  if (!isCurrentlyPlaying) {
                    await audioService.setSource(recording);
                  }

                  await audioService.playAudio();
                },
                onPause: () async {
                  log("On Pause pressed");
                  await audioService.pauseAudio();
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
