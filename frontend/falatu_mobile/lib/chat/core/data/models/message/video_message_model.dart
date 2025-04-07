import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/video_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class VideoMessageModel extends MessageModel {
  final String mediaUrl;
  final String thumbUrl;

  const VideoMessageModel({
    required this.mediaUrl,
    required this.thumbUrl,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
  });

  factory VideoMessageModel.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();
    return VideoMessageModel(
      id: json["id"],
      mediaUrl: json["mediaUrl"],
      thumbUrl: json["thumbUrl"],
      sender: UserModel.fromJson(json["sender"]),
      type: MessageType.fromValue(json["type"]),
      createdAt: createdAt,
    );
  }

  @override
  VideoMessageEntity toEntity() => VideoMessageEntity(
        id: id,
        sender: sender,
        type: type,
        createdAt: createdAt,
        mediaUrl: mediaUrl,
        thumbUrl: thumbUrl,
      );
}
