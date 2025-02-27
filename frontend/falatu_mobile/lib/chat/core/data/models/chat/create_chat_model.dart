import "package:falatu_mobile/chat/core/domain/entities/chat/create_chat_entity.dart";

class CreateChatModel extends CreateChatEntity {
  const CreateChatModel({required super.type, required super.usersIds});

  factory CreateChatModel.fromObject(CreateChatEntity object) =>
      CreateChatModel(type: object.type, usersIds: object.usersIds);

  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "usersIds": usersIds,
    };
  }
}
