import 'dart:math';

import 'package:Soullog/data/models/record.dart';
import 'package:Soullog/services/audio-service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(trackHeight: 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(), widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(inactiveTrackColor: Colors.transparent),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(
              _dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble(),
            ),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_remaining")?.group(1) ?? '$_remaining',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(title, textAlign: TextAlign.center),
          content: StreamBuilder<double>(
            stream: stream,
            builder:
                (context, snapshot) => SizedBox(
                  height: 100.0,
                  child: Column(
                    children: [
                      Text(
                        '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                        style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0),
                      ),
                      Slider(
                        divisions: divisions,
                        min: min,
                        max: max,
                        value: snapshot.data ?? value,
                        onChanged: onChanged,
                      ),
                    ],
                  ),
                ),
          ),
        ),
  );
}

T? ambiguate<T>(T? value) => value;

class ControlButtons extends StatefulWidget {
  final AudioService audioService;
  final Recording recording;
  final bool showVolumeSlider;
  final bool showSpeedSlider;
  final bool showStopButton;
  final bool showPlayPauseButton;
  final bool showSeekBar;

  const ControlButtons(
    this.audioService,
    this.recording, {
    Key? key,
    this.showVolumeSlider = false,
    this.showSpeedSlider = false,
    this.showStopButton = false,
    this.showPlayPauseButton = false,
    this.showSeekBar = false,
  }) : super(key: key);

  @override
  State<ControlButtons> createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> {
  @override
  void initState() {
    super.initState();
    //widget.audioService.setSource(widget.recording.filePath!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        if (widget.showVolumeSlider)
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust volume",
                divisions: 10,
                min: 0.0,
                max: 1.0,
                value: widget.audioService.player.volume,
                stream: widget.audioService.player.volumeStream,
                onChanged: widget.audioService.player.setVolume,
              );
            },
          ),

        StreamBuilder<PlayerState>(
          stream: widget.audioService.player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: widget.audioService.player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: widget.audioService.player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => widget.audioService.player.seek(Duration.zero),
              );
            }
          },
        ),
        if (widget.showStopButton)
          IconButton(icon: const Icon(Icons.stop), iconSize: 64.0, onPressed: widget.audioService.player.stop),
        // Opens speed slider dialog
        if (widget.showSpeedSlider)
          StreamBuilder<double>(
            stream: widget.audioService.player.speedStream,
            builder:
                (context, snapshot) => IconButton(
                  icon: Text(
                    "${snapshot.data?.toStringAsFixed(1)}x",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust speed",
                      divisions: 10,
                      min: 0.5,
                      max: 1.5,
                      value: widget.audioService.player.speed,
                      stream: widget.audioService.player.speedStream,
                      onChanged: widget.audioService.player.setSpeed,
                    );
                  },
                ),
          ),
        if (widget.showSeekBar)
          StreamBuilder<PositionData>(
            stream: widget.audioService.positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                onChangeEnd: widget.audioService.player.seek,
              );
            },
          ),
      ],
    );
  }
}
