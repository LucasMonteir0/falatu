import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/data/models/message/message_model.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/file_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/data/models/user_model.dart";

class FileMessageModel extends MessageModel {
  final XFile? file;

  const FileMessageModel({
    required this.file,
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
  });

  factory FileMessageModel.fromJson(Map<String, dynamic> json, XFile? file) {
    final createdAt = DateTime.parse(json["createdAt"]).toLocal();
    return FileMessageModel(
      id: json["id"],
      file: file,
      sender: UserModel.fromJson(json["sender"]),
      type: MessageType.fromValue(json["type"]),
      createdAt: createdAt,
    );
  }

  @override
  FileMessageEntity toEntity() => FileMessageEntity(
        id: id,
        sender: sender,
        type: type,
        createdAt: createdAt,
        file: file,
      );
}
