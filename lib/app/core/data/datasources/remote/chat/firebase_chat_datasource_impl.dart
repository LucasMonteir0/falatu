import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/commons/config/database_fields.dart';
import 'package:falatu/app/commons/config/firebase_path.dart';
import 'package:falatu/app/commons/helpers/stream_transformer.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat/chat_model.dart';
import 'package:falatu/app/core/data/models/messages/message_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseChatDatasourceImpl implements ChatDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseChatDatasourceImpl(this._firestore, this._storage);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) =>
      _firestore
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
        .snapshots();


        final kkj = result.transform(transformer(MessageModel.fromMap));
        return kkj;
    }

  @override
  Future<void> sendChatMessage(ChatModel chat, MessageModel message) async {
    final String messagesPath =
        '${FirebasePath.chats}/${chat.id}/${FirebasePath.messages}';

    await _firestore.collection(messagesPath).add(message.toMap());
    await _firestore
        .collection(FirebasePath.chats)
        .doc(chat.id)
        .update(chat.toMap());
  }

  @override
  Future<String?> uploadChatFile(File file, String chatId) async {
    final String path = 'chats/$chatId';
    final String fileName = '$chatId${DateTime
        .now()
        .millisecondsSinceEpoch}';
    String? fileUrl;
    final Reference ref = _storage.ref('$path/$fileName');
    await ref.putFile(file).whenComplete(
            () async => fileUrl = await ref.getDownloadURL());
    return fileUrl;
  }
}
