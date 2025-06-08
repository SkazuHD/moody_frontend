import 'dart:developer';

import 'package:Soullog/data/models/record.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class AudioService {
  static final AudioService _instance = AudioService._internal();

  factory AudioService() {
    return _instance;
  }

  late final AudioPlayer player;
  ValueNotifier<bool> isPlaying = ValueNotifier(false);
  ValueNotifier<int> currentMedia = ValueNotifier(-1);

  AudioService._internal() {
    player = AudioPlayer();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        //isPlaying.value = false;
        //currentMedia.value = -1;
      }
      state.playing ? isPlaying.value = true : isPlaying.value = false;
    });
    currentMedia.addListener(() {
      log("isCurrentlyPlaying changed to ${currentMedia.value}");
    });
  }

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
    player.positionStream,
    player.bufferedPositionStream,
    player.durationStream,
    (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
  );

  Future<void> setSource(Recording recording) async {
    final filePath = recording.filePath!;
    try {
      await player.setAudioSource(AudioSource.uri(Uri.parse(filePath)));
      currentMedia.value = recording.id!;
    } catch (e) {
      return Future.error('Error setting audio source: $e');
    }
  }

  Future<void> playAudio() async {
    try {
      isPlaying.value = true;
      log("Playing audio for recording ID: ${currentMedia.value}");
      await player.play();
    } catch (e) {
      return Future.error('Error playing audio: $e');
    }
  }

  Future<void> pauseAudio() async {
    try {
      await player.pause();
      isPlaying.value = false;
    } catch (e) {
      return Future.error('Error pausing audio: $e');
    }
  }

  Future<void> stopAudio() async {
    try {
      await player.stop();
      isPlaying.value = false;
      currentMedia.value = -1;
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
