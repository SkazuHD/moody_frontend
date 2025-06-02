class Recording {
  final int? id;
  final String filePath;
  final int duration;
  final DateTime createdAt;
  String? transcription;
  String? mood;

  Recording({
    this.id,
    required this.filePath,
    required this.duration,
    required this.createdAt,
    this.transcription,
    this.mood,
  });

  Map<String, dynamic> toDbValuesMap() {
    return {
      'filePath': filePath,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'transcription': transcription,
      'mood': mood,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'transcription': transcription,
      'mood': mood,
    };
  }
}
