enum MessageType {
  text,
  audio,
  video,
  image,
  file;

  factory MessageType.fromValue(String value) =>
      MessageType.values.firstWhere((e) => e.name == value);
}
