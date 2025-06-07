import 'package:flutter/material.dart';

enum Emotion {
  angry(emoji: '😠', label: 'Angry', color: Color(0xFFB25A5A), value: 1.0),
  disgusted(emoji: '🤢', label: 'Disgusted', color: Color(0xFF7A8B3F), value: 2.0),
  fear(emoji: '😨', label: 'Fear', color: Color(0xFFD9A066), value: 3.0),
  sad(emoji: '😢', label: 'Sad', color: Color(0xFF7A9EAB), value: 4.0),
  neutral(emoji: '😐', label: 'Neutral', color: Color(0xFFB0B7A8), value: 5.0),
  surprised(emoji: '😲', label: 'Surprised', color: Color(0xFF8A7D99), value: 6.0),
  calm(emoji: '😌', label: 'Calm', color: Color(0xFF88B0A0), value: 7.0),
  happy(emoji: '😊', label: 'Happy', color: Color(0xFFF5D76E), value: 8.0);

  const Emotion({required this.emoji, required this.label, required this.color, required this.value});

  final String emoji;
  final String label;
  final Color color;
  final double value;
}

Color getEmotionColor(String? mood) {
  if (mood == null) return Colors.grey;
  try {
    return Emotion.values.firstWhere((e) => e.label.toLowerCase() == mood.toLowerCase()).color;
  } catch (_) {
    return Colors.grey;
  }
}
