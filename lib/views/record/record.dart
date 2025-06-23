import 'package:Soullog/data/models/record.dart';
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

  void onRecordingStarted() {
    setState(() {
      newRecording = null;
      isAnalyzing = true;
      transcriptionController.text = '';
    });
  }

  void setNewRecording(Recording recording) {
    setState(() {
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
          Center(
            child: Text(
              'What’s on your mind',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AudioRecorderPlayer(
                    controller: transcriptionController,
                    onRecordingComplete: setNewRecording,
                    onRecordingStarted: onRecordingStarted,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Deactivate Transcription',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Center(
                        child: SwitchTranscription(
                          value: isTranscriptionActive,
                          onChanged: (val) {
                            setState(() {
                              isTranscriptionActive = val;
                              if (!val) {
                                transcriptionController.text = '';
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  if (isTranscriptionActive)
                    ObscuredTextField(
                      key: ValueKey(transcriptionController),
                      controller: transcriptionController,
                    ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed:
                        (newRecording != null && !isAnalyzing)
                            ? () async {
                              newRecording = newRecording!.copyWith(
                                transcription:
                                    isTranscriptionActive
                                        ? transcriptionController.text
                                        : '',
                              );
                              var res = await showDialog(
                                context: context,
                                builder: (context) {
                                  return PopupViewSave(
                                    recording: newRecording!,
                                  );
                                },
                              );
                              if (res == true) {
                                var db = await RecordsDB.getInstance();
                                await db.insertRecord(newRecording!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Recording saved: ${newRecording!.filePath}',
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Recording not saved'),
                                  ),
                                );
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
