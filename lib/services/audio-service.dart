import 'package:Soullog/data/models/record.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class TrackProgress {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final bool enabled;

  TrackProgress(this.position, this.bufferedPosition, this.duration, this.enabled);
}

class AudioService with WidgetsBindingObserver {
  static final AudioService _instance = AudioService._internal();
  late final AudioPlayer _player;
  bool _isInitialized = false;

  AudioPlayer get player => _player;

  factory AudioService() {
    return _instance;
  }

  final _currentMedia = BehaviorSubject<Recording?>();
  final _isPlaying = BehaviorSubject<bool>.seeded(false);
  final _playerError = BehaviorSubject<String?>.seeded(null);

  Stream<bool> isThisCurrentlyPlaying(Recording recording) =>
      Rx.combineLatest2(_currentMedia, _isPlaying, (Recording? current, bool isPlaying) {
        return current?.id == recording.id && isPlaying;
      }).shareValueSeeded(false);

  Stream<String?> get playerErrorStream => _playerError.stream;

  @pragma('vm:entry-point')
  AudioService._internal() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (!_isInitialized) {
      _player = AudioPlayer();
      _setupPlayerListeners();
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;
    }
  }

  void _setupPlayerListeners() {
    _player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        _playerError.add(e.toString());
      },
    );

    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _isPlaying.add(false);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      pause();
    }
  }

  Stream<TrackProgress> trackProgressFor(Recording recording) {
    return Rx.combineLatest4<Duration, Duration, Duration?, Recording?, TrackProgress>(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      _currentMedia.stream,
      (position, bufferedPosition, duration, currentMedia) {
        if (currentMedia == null || currentMedia.id != recording.id) {
          final recordingDuration = Duration(seconds: recording.duration ?? 0);
          return TrackProgress(Duration.zero, Duration.zero, recordingDuration, false);
        }
        return TrackProgress(position, bufferedPosition, duration ?? Duration.zero, true);
      },
    ).shareValue();
  }

  @pragma('vm:entry-point')
  Future<void> play(Recording recording) async {
    try {
      if (_currentMedia.valueOrNull != recording) {
        final filePath = recording.filePath!;
        await _player.setAudioSource(AudioSource.uri(Uri.parse(filePath)));
        _currentMedia.add(recording);
      }
      _isPlaying.add(true);
      await _player.play();
      _playerError.add(null); // Fehler zurücksetzen bei erfolgreichem Abspielen
    } catch (e) {
      _playerError.add(e.toString());
      _isPlaying.add(false);
    }
  }

  @pragma('vm:entry-point')
  Future<void> pause() async {
    await _player.pause();
    _isPlaying.add(false);
  }

  @pragma('vm:entry-point')
  Future<void> stop() async {
    await _player.stop();
    _isPlaying.add(false);
    _currentMedia.add(null);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _currentMedia.close();
    _isPlaying.close();
    _playerError.close();
    _player.dispose();
    _isInitialized = false;
  }
}
