import 'package:flutter/material.dart';

import '../data/constants/emotions.dart';
import '../data/models/record.dart';

class FilterList extends StatefulWidget {
  final List<Recording> recordings;
  final List<String> categories;

  const FilterList({
    super.key,
    required this.recordings,
    required this.categories,
  });

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final filterRecordings =
        widget.recordings.where((recording) {
          return selectedCategories.isEmpty ||
              selectedCategories.any(
                (cat) =>
                    cat.trim().toLowerCase() ==
                    (recording.mood ?? '').trim().toLowerCase(),
              );
        }).toList();
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFE4E4E4),
      ),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    widget.categories
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FilterChip(
                              selected: selectedCategories.contains(category),
                              label: Text(category),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedCategories.add(category);
                                  } else {
                                    selectedCategories.remove(category);
                                  }
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterRecordings.length,
              itemBuilder: (context, index) {
                final recording = filterRecordings[index];
                return Card(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
