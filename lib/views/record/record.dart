import 'package:Soullog/data/models/record.dart';
import 'package:flutter/material.dart';

import '/components/popupViewSave.dart';
import '../../components/ObscuredTextField.dart';
import '../../components/SwitchTransciption.dart';
import '../../components/audioRecorder.dart';

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
                    onPressed: () {
                      if (newRecording != null) {
                        Navigator.of(context).restorablePush(
                          PopupViewSave.dialogBuilder,
                          arguments: newRecording!.toJson(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No recording to save")),
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
