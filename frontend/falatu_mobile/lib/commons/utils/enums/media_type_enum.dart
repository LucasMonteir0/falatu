enum MediaTypeEnum {
  image,
  video;

  bool get isImage => this == MediaTypeEnum.image;

  bool get isVideo => this == MediaTypeEnum.video;
}
