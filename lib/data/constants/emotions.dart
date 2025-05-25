import 'package:flutter/material.dart';

enum Emotion {
  happy(emoji: '😊', label: 'Happy', color: Colors.yellow, value: 5.0),
  sad(emoji: '😢', label: 'Sad', color: Colors.blue, value: 2.0),
  calm(emoji: '😌', label: 'Calm', color: Colors.green, value: 4.0),
  fear(emoji: '😨', label: 'Fear', color: Colors.orange, value: 3.0),
  angry(emoji: '😠', label: 'Angry', color: Colors.red, value: 1.0);

  const Emotion({
    required this.emoji,
    required this.label,
    required this.color,
    required this.value,
  });

  final String emoji;
  final String label;
  final Color color;
  final double value;
}
