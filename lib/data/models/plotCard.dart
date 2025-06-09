class PlotCard {
  final int id;
  final String mood;
  final String quote;
  final String recommendation;
  final DateTime date;

  PlotCard({
    required this.id,
    required this.mood,
    required this.quote,
    required this.recommendation,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mood': mood,
      'title': quote,
      'recommendation': recommendation,
      'date': date,
    };
  }

  factory PlotCard.fromMap(Map<String, dynamic> map) {
    return PlotCard(
      id: map['id'],
      mood: map['mood'],
      quote: map['quote'],
      recommendation: map['recommendation'],
      date: map['date'],
    );
  }
}
