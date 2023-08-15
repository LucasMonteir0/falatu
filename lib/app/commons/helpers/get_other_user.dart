import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:collection/collection.dart';


UserEntity? getOtherUser(List<String> chatUsers,
    String curUserId, List<UserEntity> users) {
  String otherUserId;
  if (chatUsers.length != 1) {
    otherUserId = chatUsers.firstWhere((user) => user != curUserId);
  } else {
    otherUserId = curUserId;
  }
  UserEntity? otherUser =
  users.firstWhereOrNull((user) => user.id == otherUserId);
  return otherUser;
}