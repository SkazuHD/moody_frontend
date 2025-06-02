import 'package:flutter/material.dart';

enum Emotion {
  neutral(emoji: '😐', label: 'Neutral', color: Color(0xFFe12729), value: 8.0),
  disgusted(
    emoji: '🤢',
    label: 'Disgusted',
    color: Color(0xFFf37324),
    value: 7.0,
  ),
  surprised(
    emoji: '😲',
    label: 'Surprised',
    color: Color(0xFFf8cc1b),
    value: 6.0,
  ),
  happy(emoji: '😊', label: 'Happy', color: Color(0xFF72b043), value: 5.0),
  calm(emoji: '😌', label: 'Calm', color: Color(0xFF4d40aa), value: 4.0),
  fear(emoji: '😨', label: 'Fear', color: Color(0xFF0c8fc7), value: 3.0),
  sad(emoji: '😢', label: 'Sad', color: Color(0xFFcd75d8), value: 2.0),
  angry(emoji: '😠', label: 'Angry', color: Color(0xFF9a0fdb), value: 1.0);

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

Color getEmotionColor(String? mood) {
  if (mood == null) return Colors.grey;
  try {
    return Emotion.values
        .firstWhere((e) => e.label.toLowerCase() == mood.toLowerCase())
        .color;
  } catch (_) {
    return Colors.grey;
  }
}
