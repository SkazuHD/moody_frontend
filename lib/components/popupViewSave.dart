import 'package:flutter/material.dart';

import '/data/models/record.dart';
import '../data/constants/emotions.dart';

class PopupViewSave extends StatelessWidget {
  const PopupViewSave({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AlertDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).restorablePush(dialogBuilder);
          },
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<Object?> dialogBuilder(BuildContext context, Object? arguments) {
    final recording = Recording.fromJson(arguments as Map<String, dynamic>);
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Save Recording",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Do you want to save this recording?",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter a title for your recording',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getEmotionColor(recording.mood),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        title: Text(
                          recording.transcription as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          recording.mood as String,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 16), // Abstand zwischen den Buttons
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Save'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
