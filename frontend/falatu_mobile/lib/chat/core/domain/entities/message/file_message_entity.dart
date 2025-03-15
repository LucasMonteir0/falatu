import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";

class FileMessageEntity extends MessageEntity {
  final XFile? file;

  const FileMessageEntity({
    required super.id,
    required super.sender,
    required super.type,
    required super.createdAt,
    required this.file,
  });
}
