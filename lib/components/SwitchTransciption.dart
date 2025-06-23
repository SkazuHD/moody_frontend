import 'package:flutter/material.dart';

class SwitchTranscription extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchTranscription({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Colors.white,
      onChanged: onChanged,
    );
  }
}
