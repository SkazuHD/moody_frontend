import 'package:flutter/material.dart';

import '../../components/headlines.dart';
import '../../data/constants/emotions.dart';
import '../../data/db.dart';
import '../../data/models/record.dart';

class Fastcheckin extends StatefulWidget {
  const Fastcheckin({super.key});

  @override
  State<Fastcheckin> createState() => _FastcheckinState();
}

class _FastcheckinState extends State<Fastcheckin> {
  int? selectedEmotionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Fast check-in:', style: h1White, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Emotion.values.length,
              itemBuilder: (context, index) {
                final emotion = Emotion.values[index];
                final isSelected = selectedEmotionIndex == index;
                return GestureDetector(
                  onTap: () async {
                    if (isSelected) {
                      return;
                    }
                    setState(() {
                      selectedEmotionIndex = index;
                    });
                    final selectedMood = emotion.label;
                    final db = await RecordsDB.getInstance();
                    await db.insertRecord(
                      Recording(createdAt: DateTime.now(), transcription: null, mood: selectedMood),
                    );
                    await db.createTodaysPlotCard(selectedMood);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Your mood has been recorded!')));
                    return;
                  },
                  child: Container(
                    width: 65,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: isSelected ? 32 : 24,
                          backgroundColor: emotion.color,
                          child: Text(emotion.emoji, style: bodyWhite.copyWith(fontSize: isSelected ? 32 : 24)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          emotion.label,
                          style: bodyWhite.copyWith(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
