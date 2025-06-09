import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/constants/emotions.dart';

class EmojiAvatar extends StatefulWidget {
  final Emotion emotion;

  const EmojiAvatar({super.key, required this.emotion});

  @override
  State<EmojiAvatar> createState() => _EmojiAvatarState();
}

class _EmojiAvatarState extends State<EmojiAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 1.0,
      upperBound: 1.2,
    );

    // Bounce in
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
          HapticFeedback.lightImpact();
        });
      },
      child: ScaleTransition(
        scale: _controller,
        child: CircleAvatar(
          backgroundColor: widget.emotion.color,
          maxRadius: 32,
          child: Text(widget.emotion.emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}
