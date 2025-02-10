import "dart:io";

import "package:dio/dio.dart";

class HttpSendFilesHelper {
  HttpSendFilesHelper._();

  static Future<MultipartFile> fromBytes(
      File file, [DioMediaType? contentType]) async {
    final MultipartFile fileMultipart = MultipartFile.fromBytes(
      await file.readAsBytes(),
      filename: file.path.split("/").last,
      contentType: contentType,
    );
    return fileMultipart;
  }
}
