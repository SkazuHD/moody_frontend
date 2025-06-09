class PlotCard {
  final String mood;
  final String quote;
  final List<String> recommendation;
  final DateTime date;

  PlotCard({
    required this.mood,
    required this.quote,
    required this.recommendation,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'quote': quote,
      'recommendation': recommendation,
      'date': date,
    };
  }

  factory PlotCard.fromMap(Map<String, dynamic> map) {
    return PlotCard(
      mood: map['mood'],
      quote: map['quote'],
      recommendation: map['recommendation'],
      date: map['date'],
    );
  }
}
