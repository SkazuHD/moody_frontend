import 'dart:async';
import 'dart:io';

import 'package:Soullog/data/models/record.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../data/db.dart';
import '../data/models/plotCard.dart';
import '../services/api-service.dart';

class AudioRecorderPlayer extends StatefulWidget {
  final TextEditingController controller;
  final void Function(Recording) onRecordingComplete;
  final VoidCallback? onRecordingStarted;
  final RecorderController recorderController;

  const AudioRecorderPlayer({
    required this.controller,
    super.key,
    required this.onRecordingComplete,
    this.onRecordingStarted,
    required this.recorderController,
  });

  @override
  State<AudioRecorderPlayer> createState() => _AudioRecorderPlayerState();
}

class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
  String? audioPath;
  Timer? _timer;
  int _recordingSeconds = 0;
  bool isRecording = false;

  final recorder = AudioRecorder();

  @override
  void dispose() {
    _timer?.cancel();
    recorder.dispose();
    super.dispose();
  }

  Future<void> toggleRecording() async {
    if (await recorder.isRecording()) {
      final path = await recorder.stop();
      await widget.recorderController.stop();
      _timer?.cancel();

      if (path != null) {
        final newRecording = Recording(
          filePath: path,
          duration: _recordingSeconds,
          createdAt: DateTime.now(),
          transcription: widget.controller.text,
          mood: 'calm',
        );

        final apiService = SoullogApiService();
        final response = await apiService.analyzeRecording(newRecording);
        print('API-Answer: $response');

        final analyzedRecording = Recording(
          filePath: newRecording.filePath,
          duration: newRecording.duration,
          createdAt: newRecording.createdAt,
          transcription: response.transcription,
          mood: response.mood?.name,
        );

        widget.onRecordingComplete(analyzedRecording);

        var todaysPlotCard = PlotCard(
          mood: response.mood.toString(),
          quote: response.quote,
          recommendation:
              response.recommendations.map((e) => e.toString()).toList(),
          date: DateTime.now(),
        );

        var db = await RecordsDB.getInstance();
        db.createTodaysPlotCard(todaysPlotCard);

        setState(() {
          widget.controller.clear();
          audioPath = analyzedRecording.filePath;
          _recordingSeconds = 0;
          isRecording = false;
        });
      }
    } else {
      if (await recorder.hasPermission()) {
        widget.onRecordingStarted?.call();
        final directory = await getApplicationDocumentsDirectory();
        final audioDirectory = Directory('${directory.path}/Audio');
        if (!await audioDirectory.exists()) {
          await audioDirectory.create(recursive: true);
        }
        final filePath =
            '${audioDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.m4a';

        await recorder.start(const RecordConfig(), path: filePath);
        await widget.recorderController.record();

        _timer?.cancel();
        setState(() {
          audioPath = null;
          _recordingSeconds = 0;
          isRecording = true;
        });
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _recordingSeconds++;
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
      }
    }
  }

  Future<void> cancelRecording() async {
    if (await recorder.isRecording()) {
      await recorder.stop();
      await widget.recorderController.stop();
    }
    _timer?.cancel();
    setState(() {
      isRecording = false;
      _recordingSeconds = 0;
      audioPath = null;
    });
  }

  String get _formattedTime {
    final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: toggleRecording,
              child: SizedBox(
                width: 70,
                height: 70,
                child: Center(
                  child:
                      isRecording
                          ? Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 4),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _formattedTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          : Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                ),
              ),
            ),
          ),
          if (isRecording)
            Positioned(
              right: 0,
              top: 23,
              child: GestureDetector(
                onTap: cancelRecording,
                child: const Icon(Icons.delete, color: Colors.white, size: 40),
              ),
            ),
        ],
      ),
    );
  }
}
