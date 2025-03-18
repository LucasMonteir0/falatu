import "package:audio_waveforms/audio_waveforms.dart";
import "package:falatu_mobile/commons/ui/components/recording_dot.dart";
import "package:falatu_mobile/commons/utils/extensions/duration_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:flutter/material.dart";

class AudioMessageRecorderDisplay extends StatelessWidget {
  final Size size;
  final RecorderController controller;
  final Duration duration;

  const AudioMessageRecorderDisplay({
    required this.size,
    required this.controller,
    required this.duration,
    super.key,
  });

  static const double _padding = 8;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Row(
          children: [
            const RecordingDot(size: 20),
            16.pw,
            AudioWaveforms(
              size: Size(size.width, size.height - (_padding * 2)),
              recorderController: controller,
              waveStyle: WaveStyle(
                extendWaveform: true,
                showMiddleLine: false,
                waveColor: colors.primary,

              ),
            ),
            16.pw,
            Expanded(
                child: Text(
              duration.toTimer(hasHours: false),
              maxLines: 1,
              style: typography.bodyMedium!.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w600,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
