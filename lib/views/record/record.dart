import 'package:Soullog/data/models/record.dart';
import 'package:flutter/material.dart';

import '/components/popupViewSave.dart';
import '../../components/ObscuredTextField.dart';
import '../../components/SwitchTransciption.dart';
import '../../components/audioRecorder.dart';
import '../../components/header.dart';
import '../../data/db.dart';

Recording recording = Recording(
  id: 0,
  filePath: 'assets/test_recording.m4a',
  duration: 30,
  createdAt: DateTime.now().subtract(Duration(days: 0)),
  transcription: 'This is a sample transcription.',
  mood: 'calm',
);

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  final TextEditingController transcriptionController = TextEditingController();
  Recording? newRecording;

  void setNewRecording(Recording recording) {
    setState(() {
      newRecording = recording;
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Deactivate Transcription',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Center(child: SwitchTranscription()),
                    ],
                  ),

                  SizedBox(height: 20),
                  ObscuredTextField(controller: transcriptionController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var res = await showDialog(
                        context: context,
                        builder: (context) {
                          return PopupViewSave(recording: newRecording!);
                        },
                      );
                      if (res) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Recording saved: ${newRecording!.filePath}',
                            ),
                          ),
                        );
                        var db = await RecordsDB.getInstance();

                        db.insertRecord(newRecording!);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Recording not saved')),
                        );
                      }
                    },
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
