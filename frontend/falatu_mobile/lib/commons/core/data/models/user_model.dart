class UserModel {
  final String id;
  final String name;
  final String email;
  final String? pictureUrl;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.pictureUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        pictureUrl: json['pictureUrl']);
  }
}
