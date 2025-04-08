import "package:falatu_mobile/chat/core/domain/entities/message/message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/text_message_entity.dart";
import "package:falatu_mobile/chat/utils/enums/message_type.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_modular/flutter_modular.dart";

extension MessageExtensions on MessageEntity {
  String getLastMessageText(BuildContext context) {
    switch (type) {
      case MessageType.text:
        return (this as TextMessageEntity).text;
      case MessageType.audio:
        return "🔈 ${context.i18n.audio}";
      case MessageType.video:
        return "📹 ${context.i18n.video}";
      case MessageType.image:
        return "🖼️ ${context.i18n.image}";
      case MessageType.file:
        return "📄 ${context.i18n.file}";
    }
  }

  bool iSent() {
    return sender.id == Modular.get<SharedPreferencesService>().getUserId();
  }
}
