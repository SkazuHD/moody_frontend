import 'package:flutter/material.dart';
import 'package:record/record.dart';


class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
          Center(
            child: Text(
              'Whats on your mind',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Image.asset(
                        'assets/radio_button_checked_200dp_EA3323_FILL0_wght400_GRAD0_opsz24.png',

                      ),
                    ),
                  ),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Deactivate Transcription', style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge),
                        const Center(child: SwitchTranscription()),
                      ]
                  ),

                  SizedBox(height: 20),
                  const ObscuredTextFieldSample(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {

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

class SwitchTranscription extends StatefulWidget {
  const SwitchTranscription({super.key});

  @override
  State<SwitchTranscription> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchTranscription> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.red,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}


class ObscuredTextFieldSample extends StatelessWidget {
  const ObscuredTextFieldSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        maxLines: null,
        textAlignVertical: TextAlignVertical.top,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Transcript',
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 4),
          ),
        ),
      ),
    );
  }
}


class AudioRecorderPlayer extends StatefulWidget {
  const AudioRecorderPlayer({super.key});

  @override
  State<AudioRecorderPlayer> createState() => _AudioRecorderPlayerState();
}

class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
  bool showPlayer = false;
  String? audioPath;

  final recorder = AudioRecorder();

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  Future<void> toggleRecording() async {
    if (await recorder.isRecording()) {
      final path = await recorder.stop();
      if (path != null) {
        setState(() {
          audioPath = path;
          showPlayer = true;
        });
      }
    } else {
      if (await recorder.hasPermission()) {
        await recorder.start();
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
          child: const Text('Delete / Stop'),
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

