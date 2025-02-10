import "dart:io";

import "package:equatable/equatable.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";

class SendMessageEntity extends Equatable {
  final String senderId;
  final MessageType type;
  final String? text;
  final File? mediaFile;

  const SendMessageEntity({
    required this.senderId,
    required this.type,
    this.text,
    this.mediaFile,
  });

  @override
  List<Object?> get props => [senderId, type, text, mediaFile];
}
