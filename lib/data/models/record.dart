import 'dart:convert';
import 'dart:developer';

import 'package:Soullog/data/models/plotCard.dart';

class Recording {
  final int? id;
  final String? filePath;
  final int? duration;
  final DateTime createdAt;
  String? transcription;
  String? mood;
  final bool isFastCheckIn;
  PlotCard? plotCard;

  Recording({
    this.id,
    this.filePath,
    this.duration,
    required this.createdAt,
    this.transcription,
    this.mood,
    this.isFastCheckIn = false,
    this.plotCard,
  });

  Map<String, dynamic> toDbValuesMap() {
    return {
      'filePath': filePath,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'transcription': transcription,
      'mood': mood,
      'isFastCheckIn': isFastCheckIn ? 1 : 0,
      'plotCard': plotCard != null ? jsonEncode(plotCard) : null,
    };
  }

  Recording copyWith({
    int? id,
    String? filePath,
    int? duration,
    DateTime? createdAt,
    String? transcription,
    String? mood,
    bool? isFastCheckIn,
    PlotCard? plotCard,
  }) {
    return Recording(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      transcription: transcription ?? this.transcription,
      mood: mood ?? this.mood,
      isFastCheckIn: isFastCheckIn ?? this.isFastCheckIn,
      plotCard: plotCard ?? this.plotCard,
    );
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
      'plotCard': plotCard?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Recording(filePath: $filePath, duration: $duration, createdAt: $createdAt, transcription: $transcription, mood: $mood, isFastCheckIn: $isFastCheckIn, plotCard: $plotCard)';
  }

  factory Recording.fromJson(Map<String, dynamic> json) {
    var plotCardJson = json['plotCard'];
    PlotCard? plotCard;
    if (plotCardJson != null) {
      if (plotCardJson is String) {
        try {
          plotCardJson = jsonDecode(plotCardJson);
        } catch (e) {
          log('Fehler beim Parsen von plotCardJson: $e');
          plotCardJson = null;
        }
      }
      if (plotCardJson != null) {
        plotCard = PlotCard.fromMap(plotCardJson);
      }
    }

    return Recording(
      id: json['id'] as int?,
      filePath: json['filePath'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      transcription: json['transcription'] as String?,
      mood: json['mood'] as String?,
      isFastCheckIn: json['isFastCheckIn'] == 1,
      plotCard: plotCard,
    );
  }
}
