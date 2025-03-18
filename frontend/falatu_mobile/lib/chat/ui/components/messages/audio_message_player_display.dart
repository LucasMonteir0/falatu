import "package:audio_waveforms/audio_waveforms.dart";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/utils/constans.dart";
import "package:flutter/material.dart";

class AudioMessagePlayerDisplay extends StatefulWidget {
  final Size size;
  final PlayerController controller;
  final XFile file;
  final void Function()? onInit;

  const AudioMessagePlayerDisplay({
    required this.size,
    required this.controller,
    required this.file,
    super.key,
    this.onInit,
  });

  @override
  State<AudioMessagePlayerDisplay> createState() =>
      _AudioMessagePlayerDisplayState();
}

class _AudioMessagePlayerDisplayState extends State<AudioMessagePlayerDisplay> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AudioFileWaveforms(
      size: Size(widget.size.width, 90),
      playerController: widget.controller,
      waveformType: WaveformType.fitWidth,
      playerWaveStyle: PlayerWaveStyle(
        fixedWaveColor: colors.secondary.withValues(alpha: 0.5),
        liveWaveColor: colors.secondary,
        showSeekLine: false,
        spacing: kWaveFormSpacing,
      ),
    );
  }
}
