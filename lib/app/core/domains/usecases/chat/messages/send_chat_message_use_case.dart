import 'dart:io';

import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';

abstract class SendChatMessageUseCase {
  Future<void> sendChatMessage(ChatEntity chat, MessageEntity message, File? file);
}