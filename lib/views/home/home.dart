import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moody_frontend/components/header.dart';
import 'package:moody_frontend/components/greyButton.dart';
import 'package:moody_frontend/components/headlines.dart';
import 'package:moody_frontend/views/record/record.dart';
import 'package:moody_frontend/views/recordList/recordList.dart';

import '../dashboard/moodLinechart.dart';
import 'chartHelper.dart';

final moodSpotsNotifier = MoodSpotsNotifier();

final List<Map<String, dynamic>> emotions = [
  {'emoji': '😊', 'label': 'Happy', 'color': Color(0xFF9CD45B)},
  {'emoji': '😢', 'label': 'Sad', 'color': Color(0xFF73B4D5)},
  {'emoji': '😨', 'label': 'Fear', 'color': Color(0xFFF4A658)},
  {'emoji': '😠', 'label': 'Angry', 'color': Color(0xFFDA7167)},
  {'emoji': '😌', 'label': 'Calm', 'color': Color(0xFF46C6A8)},
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? selectedEmotionIndex;

  @override
  void initState() {
    super.initState();
    moodSpotsNotifier.fetchAndCalculateSpots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Container
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('A moment from today - would you like to capture it?', style: h1Black, textAlign: TextAlign.center,),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: greyButtonStyle,
                    onPressed: () {
                      Navigator.of(context).push(
                        //Replace with route to Home when done
                        MaterialPageRoute(builder: (context) => Record()),
                      );
                    },
                    child: const Text('Record'),
                  ),
                ],
              ),
            ),

            // 2. Container
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Fast check-in:', style: h1White, textAlign: TextAlign.center,),
                  const SizedBox(height: 16),
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
                            width: 65,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: isSelected ? 32 : 24,
                                  backgroundColor: emotion['color'],
                                  child: Text(emotion['emoji'], style: bodyWhite.copyWith(fontSize: isSelected ? 32 : 24,),),
                                ),
                                const SizedBox(height: 8),
                                Text(emotion['label'], style: bodyWhite.copyWith(
                                    fontWeight: isSelected
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

            // 3. Container mit Chart
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Mood of the past 7 days:', style: h1Black, textAlign: TextAlign.center,),
                  ValueListenableBuilder<List<FlSpot>>(
                    valueListenable: moodSpotsNotifier.spots,
                    builder: (context, spots, _) {
                      if (spots.isEmpty) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: MoodLineChart(spots: spots),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,  // 50% der Breite
                    child: Text('Review past thoughts?', style: h1White, softWrap: true,), // Text kann umbrechen
                  ),
                  SizedBox(width: 15), // Abstand zwischen Text und Button
                  Expanded(
                    flex: 1,  // 50% der Breite
                    child: ElevatedButton(
                      style: greyButtonStyle,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Record()),
                        );
                      },
                      child: const Text('To your entries'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDEBB97),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Plot card for today:', style: h1Black, textAlign: TextAlign.center,),
                  ElevatedButton(
                    style: greyButtonStyle,
                    onPressed: () {
                      Navigator.of(context).push(
                        //Replace with route to Home when done
                        MaterialPageRoute(builder: (context) => Record()),
                      );
                    },
                    child: const Text('Record'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}