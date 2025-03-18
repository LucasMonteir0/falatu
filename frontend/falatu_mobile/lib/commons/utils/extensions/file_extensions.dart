import "dart:io";

import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/utils/extensions/string_extensions.dart";

extension FileExtensions on File {
  String get fileName => path.split("/").last;

  String get extension => path.split(".").last;
}

extension XFileExtensions on XFile {
  String get fileName => path.pathToName();

  String get extension => path.split(".").last;

  void deleteSync() {
    final dir = Directory(path);
    dir.deleteSync(recursive: true);
  }

  int lengthSync() {
    return File(path).lengthSync();
  }
}
