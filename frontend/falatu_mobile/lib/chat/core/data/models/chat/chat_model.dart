import "package:falatu_mobile/chat/core/data/models/chat/group_chat_model.dart";
import "package:falatu_mobile/chat/core/data/models/chat/private_chat_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/chat/chat_entity.dart";
import "package:falatu_mobile/chat/utils/enums/chat_type.dart";

class ChatModel extends ChatEntity {
  ChatModel(
      {required super.id,
      required super.type,
      required super.createdAt,
      required super.users});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final type = ChatType.fromValue(json["type"]);

    switch(type) {
      case ChatType.private:
        return PrivateChatModel.fromJson(json);
      case ChatType.group:
       return GroupChatModel.fromJson(json);}

  }

}
