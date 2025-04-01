import "package:audio_waveforms/audio_waveforms.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/audio_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/services/audio_player_service.dart";
import "package:falatu_mobile/chat/ui/components/messages/audio_message_player_display.dart";
import "package:falatu_mobile/chat/ui/components/messages/message_container.dart";
import "package:falatu_mobile/chat/utils/constans.dart";
import "package:falatu_mobile/chat/utils/enums/audio_player_state.dart";
import "package:falatu_mobile/commons/ui/blocs/download_file_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/ui/components/falatu_user_avatar.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/duration_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:image_picker/image_picker.dart";

class AudioMessageCard extends StatefulWidget {
  final AudioMessageEntity message;
  final bool isMe;

  const AudioMessageCard({
    required this.message,
    required this.isMe,
    super.key,
  });

  @override
  State<AudioMessageCard> createState() => _AudioMessageCardState();
}

class _AudioMessageCardState extends State<AudioMessageCard> {
  late final AudioPlayerService _player;
  Duration? _duration;

  late final DownloadFileBloc _download;

  @override
  void initState() {
    super.initState();
    _player = Modular.get<AudioPlayerService>();
    _download = Modular.get<DownloadFileBloc>();

    _download.call(widget.message.mediaUrl);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Duration _handleDuration(AsyncSnapshot<Duration> snap) {
    if (snap.hasError || _duration == null) {
      return Duration.zero;
    } else if (snap.data == null ||
        (snap.data != null && snap.data!.inMilliseconds == 0)) {
      return _duration!;
    } else {
      return snap.data!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final maxWidth = MediaQuery.of(context).size.width * 0.7;
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: LayoutBuilder(builder: (context, constraints) {
        final double wavesWidth = constraints.maxWidth - 260;

        return MessageContainer(
          createdAt: widget.message.createdAt,
          maxWidth: maxWidth,
          wasSeen: false,
          isMe: widget.isMe,
          content: SizedBox(
            height: 46,
            width: maxWidth,
            child: BlocBuilder<DownloadFileBloc, BaseState>(
                bloc: _download,
                builder: (context, state) {
                  if (state is ErrorState) {
                    return const _Error();
                  } else if (state is SuccessState<XFile>) {
                    return Row(
                      children: [
                        FalaTuUserAvatar(
                          pictureUrl: widget.message.sender.pictureUrl,
                          size: 50,
                        ),
                        4.pw,
                        Expanded(
                          child: AudioMessagePlayerDisplay(
                            size: Size(wavesWidth, 50),
                            controller: _player.getController(),
                            file: state.data,
                            onInit: () async {
                              _duration = await _player.init(state.data,
                                  samplesQuantity:
                                      wavesWidth ~/ kWaveFormSpacing);
                              _player
                                  .getController()
                                  .setFinishMode(finishMode: FinishMode.pause);
                              setState(() {});
                            },
                          ),
                        ),
                        8.pw,
                        StreamBuilder<Duration>(
                            stream: _player.progressStream(),
                            builder: (context, snap) {
                              return Text(
                                _handleDuration(snap).toTimer(hasHours: false),
                                maxLines: 1,
                                style: typography.bodyMedium!.copyWith(
                                  color: colors.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                        8.pw,
                        StreamBuilder<AudioPlayerState>(
                            stream: _player.stateStream(),
                            builder: (context, snap) {
                              return FalaTuIcon(
                                icon: snap.data != null && snap.data!.isPlaying
                                    ? FalaTuIconsEnum.pause
                                    : FalaTuIconsEnum.play,
                                color: colors.secondary,
                                enableFeedback: true,
                                size: 32,
                                onTap: () {
                                  if (snap.hasError ||
                                      snap.data == null ||
                                      snap.data?.isIdle == true) {
                                    return;
                                  }
                                  if (!snap.data!.isPlaying) {
                                    _player.play();
                                    return;
                                  } else if (snap.data!.isPlaying) {
                                    _player.pause();
                                    return;
                                  }
                                },
                              );
                            }),
                      ],
                    );
                  }
                  return const _Loading();
                }),
          ),
        );
      }),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FalaTuShimmer.circle(size: 40),
        8.pw,
        const Expanded(
            flex: 3,
            child: FalaTuShimmer.rectangle(height: 25)),
        8.pw,
        const Expanded(child: FalaTuShimmer.rectangle(height: 15)),
        8.pw,
        const FalaTuShimmer.rectangle(height: 30, width: 30),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        FalaTuIcon(
          icon: FalaTuIconsEnum.error,
          color: colors.error,
          size: 36,
        ),
        8.pw,
        Expanded(
          child: Text(context.i18n.fileNotFoundError),
        ),
      ],
    );
  }
}
