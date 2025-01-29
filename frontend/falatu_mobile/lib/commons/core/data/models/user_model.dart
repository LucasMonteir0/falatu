import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.pictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        pictureUrl: json["pictureUrl"]);
  }
}
