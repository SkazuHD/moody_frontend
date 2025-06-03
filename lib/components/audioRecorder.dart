import 'dart:io';

import 'package:Soullog/data/models/record.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../data/db.dart';

class AudioRecorderPlayer extends StatefulWidget {
  final TextEditingController controller;
  final void Function(Recording) onRecordingComplete;

  const AudioRecorderPlayer({
    required this.controller,
    super.key,
    required this.onRecordingComplete,
  });

  @override
  State<AudioRecorderPlayer> createState() => _AudioRecorderPlayerState();
}

class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
  bool showPlayer = false;
  String? audioPath;
  DateTime? recordingStartTime;

  final recorder = AudioRecorder();

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  Future<void> toggleRecording() async {
    if (await recorder.isRecording()) {
      final db = await RecordsDB.getInstance();
      final path = await recorder.stop();

      if (path != null && recordingStartTime != null) {
        final duration =
            DateTime.now().difference(recordingStartTime!).inSeconds;

        final newRecording = Recording(
          filePath: path,
          duration: duration,
          createdAt: DateTime.now(),
          transcription: widget.controller.text,
          mood: 'calm',
        );

        widget.onRecordingComplete(newRecording);

        setState(() {
          widget.controller.clear();
          audioPath = newRecording.filePath;
          showPlayer = true;
        });
      }
    } else {
      if (await recorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final audioDirectory = Directory('${directory.path}/Audio');

        if (!await audioDirectory.exists()) {
          await audioDirectory.create(recursive: true);
        }
        final filePath =
            '${audioDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';

        await recorder.start(const RecordConfig(), path: filePath);
        recordingStartTime = DateTime.now();

        setState(() {
          showPlayer = false;
          audioPath = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return showPlayer
        ? Column(
          children: [
            Text('Playing: $audioPath'),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showPlayer = false;
                  audioPath = null;
                });
              },
              child: const Text('Delete'),
            ),
          ],
        )
        : InkWell(
          onTap: toggleRecording,
          child: SizedBox(
            width: 70,
            height: 70,
            child: Image.asset(
              'assets/radio_button_checked_200dp_EA3323_FILL0_wght400_GRAD0_opsz24.png',
            ),
          ),
        );
  }
}
