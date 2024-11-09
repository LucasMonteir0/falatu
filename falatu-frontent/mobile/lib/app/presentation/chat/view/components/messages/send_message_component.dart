import 'dart:io';
import 'package:falatu/app/commons/bloc_states/files_state.dart';
import 'package:falatu/app/commons/blocs/get_files_bloc.dart';
import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/commons/enums/chat_files_type.dart';
import 'package:falatu/app/commons/helpers/bottom_sheet.dart';
import 'package:falatu/app/commons/widgets/select_file_type.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_viewers_entity.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/send_chat_message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SendMessageComponent extends StatefulWidget {
  const SendMessageComponent(
      {Key? key, required this.chat, required this.userId})
      : super(key: key);

  final ChatEntity chat;
  final String userId;

  @override
  State<SendMessageComponent> createState() => _SendMessageComponentState();
}

class _SendMessageComponentState extends State<SendMessageComponent> {
  late SendChatMessageBloc _sendChatMessageBloc;
  late GetFilesBloc _getFilesBloc;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _sendChatMessageBloc = Modular.get<SendChatMessageBloc>();
    _getFilesBloc = Modular.get<GetFilesBloc>();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: BlocListener<GetFilesBloc, FileState>(
              bloc: _getFilesBloc,
              listener: (context, state) async {
                if (state is LoadedFileState) {
                  for (File file in state.files) {
                    final MessageEntity newMessage = MessageEntity(
                      message: '',
                      senderId: widget.userId,
                      timestamp: DateTime.now(),
                      type: state.type,
                      viewed: List.generate(
                        1,
                        (index) => MessageViewersEntity(
                          userId: widget.userId,
                          timestamp: DateTime.now(),
                        ),
                      ),
                    );
                    await _sendChatMessageBloc(
                        chat: widget.chat, message: newMessage, file: file);
                  }
                }
              },
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await bottomSheet(
                    context,
                    SelectFileType(
                      onTapImages: () async =>
                          await _getFilesBloc(ChatFilesType.image),
                      onTapVideos: () async =>
                          await _getFilesBloc(ChatFilesType.video),
                      onTapFiles: () async =>
                          await _getFilesBloc(ChatFilesType.file),
                    ),
                  );
                },
                icon: const Icon(Icons.add_rounded),
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    border: InputBorder.none,
                    isCollapsed: true,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  final MessageEntity newMessage = MessageEntity(
                    message: _controller.text.trim(),
                    senderId: widget.userId,
                    timestamp: DateTime.now(),
                    type: Strings.textType,
                    viewed: List.generate(
                      1,
                      (index) => MessageViewersEntity(
                        userId: widget.userId,
                        timestamp: DateTime.now(),
                      ),
                    ),
                  );

                  if (_controller.text.trim().isNotEmpty) {
                    await _sendChatMessageBloc(
                        chat: widget.chat, message: newMessage);
                  }
                },
                icon: const Icon(Icons.send_rounded)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _getFilesBloc.close();
    _controller.dispose();
    _sendChatMessageBloc.close();
    super.dispose();
  }
}
