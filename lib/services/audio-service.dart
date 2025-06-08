import 'package:Soullog/data/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../components/AudioControlComponents.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();

  factory AudioService() {
    return _instance;
  }

  late final AudioPlayer player;
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<int> isCurrentlyPlaying = ValueNotifier(-1);

  AudioService._internal() {
    player = AudioPlayer();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isPlaying.value = false;
        isCurrentlyPlaying.value = -1;
      }
      state.playing ? isPlaying.value = true : isPlaying.value = false;
    });
  }

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
    player.positionStream,
    player.bufferedPositionStream,
    player.durationStream,
    (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
  );

  Future<void> setSource(String filePath) async {
    print(filePath);
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(filePath)));
    } catch (e) {
      return Future.error('Error setting audio source: $e');
    }
  }

  Future<void> playAudio(Recording recording) async {
    try {
      await player.play();
      isPlaying.value = true;
      isCurrentlyPlaying.value = recording.id!;
    } catch (e) {
      return Future.error('Error playing audio: $e');
    }
  }

  Future<void> pauseAudio() async {
    try {
      await player.pause();
      isPlaying.value = false;
      isCurrentlyPlaying.value = -1;
    } catch (e) {
      return Future.error('Error pausing audio: $e');
    }
  }

  Future<void> resumeAudio() async {
    try {
      await player.play();
      isPlaying.value = true;
    } catch (e) {
      return Future.error('Error resuming audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await player.stop();
      isPlaying.value = false;
      isCurrentlyPlaying.value = -1;
    } catch (e) {
      return Future.error('Error stopping audio: $e');
    }
  }

  Future<void> seekAudio(Duration position) async {
    try {
      await player.seek(position);
    } catch (e) {
      return Future.error('Error seeking audio: $e');
    }
  }
}
