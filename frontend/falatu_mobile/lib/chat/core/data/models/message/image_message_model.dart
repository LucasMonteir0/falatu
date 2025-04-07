import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/image_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class ImageMessageModel extends MessageModel {
  final String mediaUrl;
  final String? text;

  const ImageMessageModel({
    required this.mediaUrl,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.text,
  });

  factory ImageMessageModel.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();
    return ImageMessageModel(
      id: json["id"],
      mediaUrl: json["mediaUrl"],
      sender: UserModel.fromJson(json["sender"]),
      type: MessageType.fromValue(json["type"]),
      createdAt: createdAt,
      text: json["text"],
    );
  }

  @override
  ImageMessageEntity toEntity() => ImageMessageEntity(
        id: id,
        sender: sender,
        type: type,
        createdAt: createdAt,
        mediaUrl: mediaUrl,
        text: text,
      );
}
