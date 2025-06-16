import 'package:flutter/material.dart';

enum Emotion {
  angry(emoji: '😠', label: 'Angry', color: Color(0xFFB25A5A), value: 1.0),
  disgusted(emoji: '🤢', label: 'Disgust', color: Color(0xFF7A8B3F), value: 2.0),
  fear(emoji: '😨', label: 'Fearful', color: Color(0xFFD9A066), value: 3.0),
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

  static Color getEmotionColor(String? mood) {
    if (mood == null) return Colors.grey;
    try {
      return Emotion.values.firstWhere((e) => e.label.toLowerCase() == mood.toLowerCase()).color;
    } catch (_) {
      return Colors.grey;
    }
  }

  static String getEmotionEmoji(String? mood) {
    if (mood == null) return '😐';
    try {
      return Emotion.values.firstWhere((e) => e.label.toLowerCase() == mood.toLowerCase()).emoji;
    } catch (_) {
      return '😐';
    }
  }

  static double getEmotionValue(String? mood) {
    if (mood == null) return 0;
    try {
      return Emotion.values.firstWhere((e) => e.label.toLowerCase() == mood.toLowerCase()).value;
    } catch (_) {
      return 0;
    }
  }
}

class EmotionMetadata {
  final String validationMessage;

  const EmotionMetadata({required this.validationMessage});
}

const Map<Emotion, EmotionMetadata> emotionMetadata = {
  Emotion.angry: EmotionMetadata(validationMessage: "Anger is valid too."),
  Emotion.disgusted: EmotionMetadata(validationMessage: "Not a great moment — let’s log it."),
  Emotion.fear: EmotionMetadata(validationMessage: "It's okay to feel fear. Let's acknowledge it."),
  Emotion.sad: EmotionMetadata(validationMessage: "Tough day? Let's log it."),
  Emotion.neutral: EmotionMetadata(validationMessage: "A neutral moment is worth logging too."),
  Emotion.surprised: EmotionMetadata(validationMessage: "Surprised? Let’s capture that."),
  Emotion.calm: EmotionMetadata(validationMessage: "Feeling calm? Nice, let's lock that in."),
  Emotion.happy: EmotionMetadata(validationMessage: "Great to hear that!"),
};
