class Recording {
  final int id;
  final String filePath;
  final int duration;
  final DateTime createdAt;
  String? transcription;
  String? mood;

  Recording({
    required this.id,
    required this.filePath,
    required this.duration,
    required this.createdAt,
    this.transcription,
    this.mood,
  });

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

List<Recording> recordings = [
  Recording(
    id: 1,
    filePath: 'assets/audio/recording1.mp3',
    duration: 30,
    createdAt: DateTime.now(),
    transcription: 'This is a sample transcription.',
    mood: 'Happy',
  ),
  Recording(
    id: 2,
    filePath: 'assets/audio/recording2.mp3',
    duration: 12,
    createdAt: DateTime.now(),
    transcription: 'Another sample transcription.',
    mood: 'Sad',
  ),
  // Add more recordings as needed
  Recording(
    id: 3,
    filePath: 'assets/audio/recording3.mp3',
    duration: 45,
    createdAt: DateTime.now(),
    transcription: 'This is another sample transcription.',
    mood: 'Angry',
  ),
  Recording(
    id: 4,
    filePath: 'assets/audio/recording4.mp3',
    duration: 20,
    createdAt: DateTime.now(),
    transcription: 'Yet another sample transcription.',
    mood: 'Surprised',
  ),
  Recording(
    id: 5,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now(),
    transcription: 'Final sample transcription.',
    mood: 'Neutral',
  ),
];
