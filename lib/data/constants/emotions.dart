import 'package:flutter/material.dart';

enum Emotion {
  happy(emoji: '😊', label: 'Happy', color: Colors.yellow, value: 5),
  sad(emoji: '😢', label: 'Sad', color: Colors.blue, value: 4),
  calm(emoji: '😌', label: 'Calm', color: Colors.green, value: 3),
  fear(emoji: '😨', label: 'Fear', color: Colors.orange, value: 2),
  angry(emoji: '😠', label: 'Angry', color: Colors.red, value: 1);

  const Emotion({
    required this.emoji,
    required this.label,
    required this.color,
    required this.value,
  });

  final String emoji;
  final String label;
  final Color color;
  final int value;
}
