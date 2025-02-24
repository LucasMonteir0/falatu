import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/text_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class TextMessageModel extends MessageModel {
  final String text;

  const TextMessageModel({
    required this.text,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
  });

  factory TextMessageModel.fromJson(Map<String, dynamic> json) =>
      TextMessageModel(
        id: json["id"],
        text: json["text"],
        sender: UserModel.fromJson(json["sender"]),
        type: MessageType.fromValue(json["type"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  @override
  TextMessageEntity toEntity() => TextMessageEntity(
      id: id, sender: sender, type: type, createdAt: createdAt, text: text, );
}
