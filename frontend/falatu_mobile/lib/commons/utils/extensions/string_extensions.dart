extension PathExtensions on String {
  String pathToName({bool hasExtension = true}) {
    final decodedPath = Uri.decodeFull(this);
    String fileName =
        decodedPath.split("/").last.split(".").first.split("-fDTIME0:").first;

    final extension = split(".").last;

    if (!hasExtension) {
      return fileName;
    }
    return "$fileName.$extension";
  }
}
