import 'dart:io';

import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat/chat_model.dart';
import 'package:falatu/app/core/data/models/messages/message_model.dart';
import 'package:falatu/app/core/domains/entities/chat/chat_entity.dart';
import 'package:falatu/app/core/domains/entities/messages/message_entity.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource _datasource;

  ChatRepositoryImpl(this._datasource);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) {
    return _datasource.getPrivateChats(userId);
  }

  @override
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    return _datasource.getChatMessages(chatId);
  }

  @override
  Future<void> sendChatMessage(
      ChatEntity chat, MessageEntity message, File? file) async {
    String lastMessage = '';
    String? fileUrl = '';
    if (file != null) {
      fileUrl = await _datasource.uploadChatFile(file, chat.id);
    }

    switch (message.type) {
      case Strings.textType:
        lastMessage = message.message;
        break;
      case Strings.documentType:
        lastMessage = 'Arquivo';
        break;
      case Strings.audioType:
        lastMessage = 'Áudio';
        break;
      case Strings.imageType:
        lastMessage = 'Imagem';
        break;
      case Strings.videoType:
        lastMessage = 'Vídeo';
        break;
      default:
        return;
    }

    final ChatModel newChat = ChatModel(
      id: chat.id,
      lastMessage: lastMessage,
      lastMessageTime: message.timestamp,
      users: chat.users,
      type: chat.type,
    );
    final int? size = file != null ? await file!.length() : null;
    final MessageModel newMessage = MessageModel(
      message: message.message,
      senderId: message.senderId,
      timestamp: message.timestamp,
      type: message.type,
      viewed: message.viewed,
      documentUrl: file != null ? fileUrl : null,
      extension: file != null ? file!.path.split('.').last.toUpperCase() : null,
      size: size.toString(),
    );

    await _datasource.sendChatMessage(
      ChatModel.fromEntity(newChat),
      MessageModel.fromEntity(newMessage),
    );
  }
}
