import 'package:flutter/material.dart';

import '../../components/headlines.dart';
import '../../data/constants/emotions.dart';
import '../../data/db.dart';
import '../../data/models/record.dart';

class Fastcheckin extends StatefulWidget {
  final VoidCallback onDataChanged;

  const Fastcheckin({super.key, required this.onDataChanged});

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

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Mood'),
                          content: Text(
                            'Are you sure you want to record your mood as "${emotion.label}"?',
                            style: bodyBlack,
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                            TextButton(
                              onPressed: () async {
                                final selectedMood = emotion.label;
                                final db = await RecordsDB.getInstance();
                                await db.insertRecord(
                                  Recording(
                                    createdAt: DateTime.now(),
                                    transcription: null,
                                    mood: selectedMood,
                                    isFastCheckIn: true,
                                  ),
                                );
                                await db.createTodaysPlotCard(selectedMood);
                                widget.onDataChanged();
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(const SnackBar(content: Text('Your mood has been recorded!')));
                                return Navigator.of(context).pop();
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
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
