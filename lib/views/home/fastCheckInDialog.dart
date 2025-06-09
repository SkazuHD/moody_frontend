import 'package:Soullog/components/emojiAvatar.dart';
import 'package:Soullog/data/constants/emotions.dart';
import 'package:flutter/material.dart';

import '../../components/headlines.dart';

class FastCheckInDialog extends StatelessWidget {
  final Emotion emotion;

  const FastCheckInDialog({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Fast Check-In', style: h1Black)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmojiAvatar(emotion: emotion),
          const SizedBox(height: 24),
          Text(
            '${emotionMetadata[emotion]?.validationMessage ?? "Log this moment?"} '
            'Want to record your mood as "${emotion.label}"?',
            style: bodyBlack,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Log Mood')),
      ],
    );
  }
}
