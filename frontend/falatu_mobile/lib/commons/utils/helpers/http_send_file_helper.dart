
import "package:cross_file/cross_file.dart";
import "package:dio/dio.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";

class HttpSendFilesHelper {
  HttpSendFilesHelper._();

  static Future<MultipartFile> fromFile(XFile file,
      [DioMediaType? contentType]) async {
    final fileType = file.mimeType.let((e) {
      final split = e.split("/");
      return DioMediaType(split.first, split.last);
    });

    final MultipartFile fileMultipart = MultipartFile.fromBytes(
      await file.readAsBytes(),
      filename: file.path.split("/").last,
      contentType: contentType ?? fileType,
    );

    return fileMultipart;
  }
}
