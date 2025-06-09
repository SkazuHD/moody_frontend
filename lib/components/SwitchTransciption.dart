import 'package:flutter/material.dart';

class SwitchTranscription extends StatefulWidget {
  const SwitchTranscription({super.key});

  @override
  State<SwitchTranscription> createState() => _SwitchState();
}

class _SwitchState extends State<SwitchTranscription> {
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
