import 'package:Soullog/data/models/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class TrackProgress {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  final bool enabled;

  TrackProgress(this.position, this.bufferedPosition, this.duration, this.enabled);
}

class AudioService {
  static final AudioService _instance = AudioService._internal();
  late final AudioPlayer _player;

  AudioPlayer get player => _player;

  factory AudioService() {
    return _instance;
  }

  final _currentMedia = BehaviorSubject<Recording?>();
  final _isPlaying = BehaviorSubject<bool>.seeded(false);

  Stream<bool> isThisCurrentlyPlaying(Recording recording) =>
      Rx.combineLatest2(_currentMedia, _isPlaying, (Recording? current, bool isPlaying) {
        return current?.id == recording.id && isPlaying;
      });

  @pragma('vm:entry-point')
  AudioService._internal() {
    _player = AudioPlayer();
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
    );
  }

  @pragma('vm:entry-point')
  Future<void> play(Recording recording) async {
    if (_currentMedia.valueOrNull != recording) {
      final filePath = recording.filePath!;
      await _player.setAudioSource(AudioSource.uri(Uri.parse(filePath)));
      _currentMedia.add(recording);
    }
    _isPlaying.add(true);
    await _player.play();
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
    _currentMedia.close();
    _isPlaying.close();
    _player.dispose();
  }
}
