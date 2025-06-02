class PlotCard {
  final String mood;
  final String title;
  final String description;
  final DateTime date;

  PlotCard({
    required this.mood,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'title': title,
      'message': description,
      'date': date,
    };
  }

  factory PlotCard.fromMap(Map<String, dynamic> map) {
    return PlotCard(
      mood: map['mood'],
      title: map['title'],
      description: map['message'],
      date: map['date'],
    );
  }
}
