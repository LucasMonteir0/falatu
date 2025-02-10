import "dart:io";

extension FileExtensions on File {
  String get fileName => path.split("/").last;
  String get extension => path.split(".").last;
}
