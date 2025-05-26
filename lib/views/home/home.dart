import 'package:Soullog/components/greyButton.dart';
import 'package:Soullog/components/header.dart';
import 'package:Soullog/components/headlines.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> emotions = [
  {'emoji': '😊', 'label': 'Happy', 'color': Colors.yellow},
  {'emoji': '😢', 'label': 'Sad', 'color': Colors.blue},
  {'emoji': '😌', 'label': 'Calm', 'color': Colors.green},
  {'emoji': '😨', 'label': 'Fear', 'color': Colors.orange},
  {'emoji': '😠', 'label': 'Angry', 'color': Colors.red},
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedEmotionIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'A moment from today - would you like to capture it?',
                style: h1White,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: greyButtonStyle,
                onPressed: () {
                  // TODO: Action
                },
                child: const Text('Record'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Fast check in:',
                style: h1White,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: emotions.length,
                  itemBuilder: (context, index) {
                    final emotion = emotions[index];
                    final isSelected = selectedEmotionIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEmotionIndex = index;
                        });
                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: isSelected ? 32 : 24,
                              backgroundColor: emotion['color'],
                              child: Text(
                                emotion['emoji'],
                                style: bodyWhite.copyWith(
                                  fontSize: isSelected ? 32 : 24,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              emotion['label'],
                              style: bodyWhite.copyWith(
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
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
        ),
      ),
    );
  }
}
