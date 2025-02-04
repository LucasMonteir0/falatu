enum ChatRole {
  member,
  admin;

  factory ChatRole.fromValue(String value) =>
      ChatRole.values.firstWhere((e) => e.name == value);
}
