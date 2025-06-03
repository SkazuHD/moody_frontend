class Recording {
  final int? id;
  final String? filePath;
  final int? duration;
  final DateTime createdAt;
  String? transcription;
  String? mood;
  final bool isFastCheckIn;

  Recording({
    this.id,
    this.filePath,
    this.duration,
    required this.createdAt,
    this.transcription,
    this.mood,
    this.isFastCheckIn = false,
  });

  Map<String, dynamic> toDbValuesMap() {
    return {
      'filePath': filePath,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'transcription': transcription,
      'mood': mood,
      'isFastCheckIn': isFastCheckIn ? 1 : 0,
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
      'isFastCheckIn': isFastCheckIn ? 1 : 0,
    };
  }

  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      id: json['id'] as int?,
      filePath: json['filePath'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      transcription: json['transcription'] as String?,
      mood: json['mood'] as String?,
      isFastCheckIn: json['isFastCheckIn'] == 1,
    );
  }
}
