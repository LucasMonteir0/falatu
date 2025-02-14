import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:flutter/cupertino.dart";

enum ChatTabs {
  friends,
  groups;

  String getLabel(BuildContext context) {
    switch (this) {
      case ChatTabs.friends:
        return context.i18n.friendsTab;
      case ChatTabs.groups:
        return context.i18n.groupsTab;
    }
  }
}
