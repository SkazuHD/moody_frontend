import 'package:flutter/material.dart';

import '/data/db.dart';
import '/data/models/record.dart';
import '../data/constants/emotions.dart';

class PopupViewSave {
  @pragma('vm:entry-point')
  static Route<Object?> dialogBuilder(BuildContext context, Object? arguments) {
    final recording = Recording.fromJson(arguments as Map<String, dynamic>);

    return DialogRoute<void>(
      context: context,
      builder: (BuildContext innerContext) {
        return AlertDialog(
          title: Text(
            "Save Recording",
            style: Theme.of(innerContext).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Do you want to save this recording?",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
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
                          recording.transcription ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          recording.mood ?? '',
                          style: const TextStyle(color: Colors.white),
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
                      textStyle: Theme.of(innerContext).textTheme.labelLarge,
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(innerContext).pop();
                    },
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(innerContext).textTheme.labelLarge,
                    ),
                    child: const Text('Save'),
                    onPressed: () async {
                      final db = await RecordsDB.getInstance();
                      await db.insertRecord(recording);

                      Navigator.of(innerContext).pop();
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
