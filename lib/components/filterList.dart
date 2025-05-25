import 'package:flutter/material.dart';

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
        recordings.where((recording) {
          return selectedCategories.isEmpty ||
              selectedCategories.contains(recording.mood);
        }).toList();
    return Column(
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
                  decoration: const BoxDecoration(color: Colors.indigoAccent),
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
    );
  }
}
