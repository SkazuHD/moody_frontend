import 'package:Soullog/components/plotCardComponent.dart';
import 'package:Soullog/data/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/emojiAvatar.dart';
import '../../components/headlines.dart';
import '../../data/constants/emotions.dart';
import '../../helper/dateHelper.dart';

class RecordListDialog extends StatelessWidget {
  final Recording recording;

  const RecordListDialog({super.key, required this.recording});

  @override
  Widget build(BuildContext context) {

    var emotion = Emotion.getEmotionFromLabel(recording.mood);
    var recordingDate = recording.createdAt;

    return AlertDialog(
      title: Center(child: Column(
        children: [
          Text(recording.mood ?? "NAH", style: h1Black),

        ],
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmojiAvatar(emotion: emotion),
          const SizedBox(height: 24),
          Text(
            getFullDate(recordingDate),
            style: h2Black,
          ),
          const SizedBox(height: 24),
          Text(recording.plotCard!.quote.toString() ?? "", style: bodyBlack.copyWith(fontStyle: FontStyle.italic),textAlign: TextAlign.center),
          const SizedBox(height: 24),
          if (recording.transcription != null) ...[
            Text("Transcription:", style: h2Black),
            Text(recording.transcription ?? "No transcription available", style: bodyBlack),
          ],
          const SizedBox(height: 16),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Close')),
      ],
    );
  }
}
