import 'dart:developer';

import 'package:Soullog/data/models/record.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import '/components/popupViewSave.dart';
import '../../components/ObscuredTextField.dart';
import '../../components/SwitchTransciption.dart';
import '../../components/audioRecorder.dart';
import '../../components/header.dart';
import '../../data/db.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  final TextEditingController transcriptionController = TextEditingController();
  Recording? newRecording;
  bool isAnalyzing = false;
  bool isTranscriptionActive = true;
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  void onRecordingStarted() {
    setState(() {
      newRecording = null;
      isAnalyzing = true;
      transcriptionController.text = '';
    });
  }

  void setNewRecording(Recording recording) {
    setState(() {
      log("New recording set: ${recording}");
      newRecording = recording;
      isAnalyzing = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      transcriptionController.text = recording.transcription ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Center(child: Text('What’s on your mind', style: Theme.of(context).textTheme.bodyLarge)),
          const SizedBox(height: 80),
          Center(
            child: AudioWaveforms(
              enableGesture: false,
              size: Size(MediaQuery.of(context).size.width * 0.55, 120),
              recorderController: recorderController,
              waveStyle: const WaveStyle(waveColor: Colors.black, extendWaveform: true, showMiddleLine: false),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AudioRecorderPlayer(
                    controller: transcriptionController,
                    onRecordingComplete: setNewRecording,
                    onRecordingStarted: onRecordingStarted,
                    recorderController: recorderController,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Deactivate Transcription', style: Theme.of(context).textTheme.bodyLarge),
                      Center(
                        child: SwitchTranscription(
                          value: isTranscriptionActive,
                          onChanged: (val) {
                            setState(() {
                              isTranscriptionActive = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  if (isTranscriptionActive)
                    ObscuredTextField(key: ValueKey(transcriptionController), controller: transcriptionController),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed:
                        (newRecording != null && !isAnalyzing)
                            ? () async {
                              newRecording = newRecording!.copyWith(
                                transcription: isTranscriptionActive ? transcriptionController.text : '',
                              );
                              var res = await showDialog(
                                context: context,
                                builder: (context) {
                                  return PopupViewSave(recording: newRecording!);
                                },
                              );
                              if (res == true) {
                                var db = await RecordsDB.getInstance();
                                log("Saving recording: ${newRecording!}");
                                await db.insertRecord(newRecording!);
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text('Recording saved: ${newRecording!.filePath}')));
                              } else {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Recording not saved')));
                              }
                            }
                            : null,
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
