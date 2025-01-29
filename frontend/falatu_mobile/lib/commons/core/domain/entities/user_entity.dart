import "package:equatable/equatable.dart";

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? pictureUrl;

  const UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.pictureUrl});

  @override
  List<Object?> get props => [id, name, email, pictureUrl];
}
