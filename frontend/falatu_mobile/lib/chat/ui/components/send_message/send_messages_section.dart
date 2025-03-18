import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_audio_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_text_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/services/audio_recorder_service.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/components/media/pick_files_bottom_sheet.dart";
import "package:falatu_mobile/chat/ui/components/send_message/audio_message_recorder_display.dart";
import "package:falatu_mobile/chat/ui/components/send_message/message_input.dart";
import "package:falatu_mobile/chat/ui/components/send_message/send_message_button.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/blocs/timer_bloc.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:path_provider/path_provider.dart";

enum MessagesHandlerState {
  idle,
  writing,
  recording;

  bool get isIdle => this == idle;

  bool get isWriting => this == writing;

  bool get isRecording => this == recording;
}

class SendMessagesSection extends StatefulWidget {
  final TextEditingController textController;
  final SendMessageBloc bloc;
  final String chatId;

  const SendMessagesSection(
      {required this.textController,
      required this.bloc,
      required this.chatId,
      super.key});

  @override
  State<SendMessagesSection> createState() => _SendMessagesSectionState();
}

class _SendMessagesSectionState extends State<SendMessagesSection> {
  late final ValueNotifier<MessagesHandlerState> _stateNotifier =
      ValueNotifier(MessagesHandlerState.idle);

  late final AudioRecorderService _recorder;
  final TimerBloc _timer = TimerBloc();

  @override
  void initState() {
    super.initState();
    _recorder = Modular.get<AudioRecorderService>();
  }

  @override
  void dispose() {
    _timer.close();
    _recorder.dispose();
    super.dispose();
  }

  final userId = Modular.get<SharedPreferencesService>().getUserId()!;
  XFile? _recordedFile;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _stateNotifier,
        builder: (context, state, _) {
          return BlocConsumer<TimerBloc, Duration>(
            bloc: _timer,
            listener: (context, duration) {
              if (duration.inMinutes >= 2) {
                _recorder.pause();
                _timer.toggle();
              }
            },
            builder: (context, duration) {
              return Row(
                children: [
                  if (!state.isRecording)
                    Expanded(
                      child: MessageInput(
                        controller: widget.textController,
                        onChanged: (text) {
                          if (text.trim().isNotEmpty) {
                            _stateNotifier.value = MessagesHandlerState.writing;
                          } else {
                            _stateNotifier.value = MessagesHandlerState.idle;
                          }
                        },
                        onAddTap: () => PickFilesBottomSheet.show(context,
                            chatId: widget.chatId),
                      ),
                    )
                  else
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return AudioMessageRecorderDisplay(
                          size: Size(constraints.maxWidth - 110, 52),
                          controller: _recorder.controller,
                          duration: duration,
                        );
                      }),
                    ),
                  4.pw,
                  if (state.isRecording)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FalaTuIcon(
                        icon: FalaTuIconsEnum.deleteFilled,
                        onTap: () async {
                          final file = await _recorder.stop();
                          _timer.stop();
                          file?.deleteSync();
                          _stateNotifier.value = MessagesHandlerState.idle;
                        },
                      ),
                    ),
                  BlocListener<SendMessageBloc, BaseState>(
                    bloc: widget.bloc,
                    listener: (context, state) {
                      if (state is SuccessState) {
                        _recordedFile?.deleteSync();
                      }
                    },
                    child: SendMessageButton(
                      state: state,
                      onTap: () async {
                        if (state.isWriting) {
                          if (widget.textController.text.trim().isEmpty) {
                            return;
                          }
                          final message = SendTextMessageEntity(
                              senderId: userId,
                              text: widget.textController.text.trim());

                          widget.bloc.call(widget.chatId, message);
                          widget.textController.clear();
                        }

                        if (state.isRecording) {
                          if (duration.inSeconds < 1) {
                            return;
                          }
                          final file = await _recorder.stop();
                          _timer.stop();
                          _stateNotifier.value = MessagesHandlerState.idle;
                          _recordedFile = file;

                          final message = SendAudioMessageEntity(
                              senderId: userId, mediaFile: file);

                          widget.bloc.call(widget.chatId, message);
                          return;
                        }
                        if (state.isIdle) {
                          final dir = await getTemporaryDirectory();
                          await _recorder.start(
                            "${dir.path}/falatu_last_recorded_audio_message.m4a",
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          _timer.start();
                          _stateNotifier.value = MessagesHandlerState.recording;
                          return;
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
