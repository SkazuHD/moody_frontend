class PlotCard {
  final String mood;
  final String quote;
  final List<String> recommendation;
  final DateTime date;
  final bool isEmpty;

  PlotCard({
    required this.mood,
    required this.quote,
    required this.recommendation,
    required this.date,
    this.isEmpty = false,
  });

  Map<String, dynamic> toJson() {
    return {'mood': mood, 'quote': quote, 'recommendation': recommendation, 'date': date.toIso8601String()};
  }

  factory PlotCard.fromMap(Map<String, dynamic> map) {
    return PlotCard(
      mood: map['mood'],
      quote: map['quote'],
      recommendation: List<String>.from(map['recommendation']),
      date: DateTime.parse(map['date']),
    );
  }
}
