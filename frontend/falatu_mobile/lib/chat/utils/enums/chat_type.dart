enum ChatType {
  private,
  group;

  factory ChatType.fromValue(String value) =>
      ChatType.values.firstWhere((e) => e.name == value);
}
