import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/commons/config/database_fields.dart';
import 'package:falatu/app/commons/config/firebase_path.dart';
import 'package:falatu/app/commons/config/strings.dart';
import 'package:falatu/app/commons/helpers/stream_transformer.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat_model.dart';
import 'package:falatu/app/core/data/models/message_model.dart';

class FirebaseChatDatasourceImpl implements ChatDatasource {
  final FirebaseFirestore _firestore;

  FirebaseChatDatasourceImpl(this._firestore);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) => _firestore
      .collection(FirebasePath.chats)
      .where(DataBaseFields.users, arrayContains: userId)
      .where(DataBaseFields.chatType, isEqualTo: DataBaseFields.private)
      .orderBy(DataBaseFields.lastMessageTime, descending: true)
      .snapshots()
      .transform(transformer(ChatModel.fromMap));

  @override
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    final String path =
        '${FirebasePath.chats}/$chatId/${FirebasePath.messages}';
    final result = _firestore
        .collection(path)
        .orderBy(DataBaseFields.timestamp, descending: false)
        .snapshots()
        .transform(transformer(MessageModel.fromMap));

    return result;
  }

  @override
  Future<void> sendChatMessage(ChatModel chat, MessageModel message) async {
    final String messagesPath =
        '${FirebasePath.chats}/${chat.id}/${FirebasePath.messages}';

    String lastMessage = '';

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

    await _firestore.collection(messagesPath).add(message.toMap());
    await _firestore
        .collection(FirebasePath.chats)
        .doc(chat.id)
        .update(newChat.toMap());
  }
}
