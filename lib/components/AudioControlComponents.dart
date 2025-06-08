import 'dart:math';

import 'package:flutter/material.dart';

import '../services/audio-service.dart';

class AudioControls extends StatelessWidget {
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final bool isPlaying;
  final AudioService audioService = AudioService();
  final Stream<TrackProgress> trackProgress;

  AudioControls({super.key, this.onPlay, this.onPause, this.isPlaying = false, required this.trackProgress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!isPlaying)
            IconButton(icon: const Icon(Icons.play_arrow, size: 30), onPressed: () => {if (onPlay != null) onPlay!()}),
          if (isPlaying)
            IconButton(icon: const Icon(Icons.pause, size: 30), onPressed: () => {if (onPause != null) onPause!()}),
          Expanded(
            child: StreamBuilder<TrackProgress>(
              stream: trackProgress,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: audioService.player.seek,
                  enabled: isPlaying || (positionData?.enabled ?? false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final bool enabled;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    required this.enabled,
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
    final enabled = widget.enabled;
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
              onChanged:
                  enabled
                      ? (value) {
                        setState(() {
                          _dragValue = value;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(Duration(milliseconds: value.round()));
                        }
                      }
                      : null,
              onChangeEnd:
                  enabled
                      ? (value) {
                        if (widget.onChangeEnd != null) {
                          widget.onChangeEnd!(Duration(milliseconds: value.round()));
                        }
                        _dragValue = null;
                      }
                      : null,
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
            onChanged:
                enabled
                    ? (value) {
                      setState(() {
                        _dragValue = value;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(Duration(milliseconds: value.round()));
                      }
                    }
                    : null,
            onChangeEnd:
                enabled
                    ? (value) {
                      if (widget.onChangeEnd != null) {
                        widget.onChangeEnd!(Duration(milliseconds: value.round()));
                      }
                      _dragValue = null;
                    }
                    : null,
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
