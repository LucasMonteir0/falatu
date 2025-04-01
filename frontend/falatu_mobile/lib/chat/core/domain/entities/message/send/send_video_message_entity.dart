import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendVideoMessageEntity extends SendMessageEntity {
  final XFile? thumbFile;

  const SendVideoMessageEntity({
    required super.senderId,
    required XFile mediaFile,
    this.thumbFile,
    super.text,
    super.type = MessageType.video,
  }) : super(mediaFile: mediaFile);
}
