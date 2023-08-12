import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/commons/config/database_fields.dart';
import 'package:falatu/app/commons/config/firebase_path.dart';
import 'package:falatu/app/commons/helpers/stream_transformer.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/models/chat_model.dart';

class FirebaseChatDatasourceImpl implements ChatDatasource {
  final FirebaseFirestore _firestore;

  FirebaseChatDatasourceImpl(this._firestore);

  @override
  Stream<List<ChatModel>> getPrivateChats(String userId) => _firestore
      .collection(FirebasePath.chats)
      .where(DataBaseFields.users, arrayContains: userId)
      .where(DataBaseFields.type, isEqualTo: DataBaseFields.private)
      .orderBy(DataBaseFields.lastMessageTime, descending: true)
      .snapshots()
      .transform(Teste.transformer(ChatModel.fromMap));
}
