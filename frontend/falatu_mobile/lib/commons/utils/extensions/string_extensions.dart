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

extension StringExtensions on String {
  String toFirstAndLastName() {
    List<String> splittedName = split(" ");
    if (splittedName.length <= 1) {
      return this;
    }
    String firstName = splittedName.first;
    String secondName = splittedName.last;
    return "$firstName $secondName";
  }
}
