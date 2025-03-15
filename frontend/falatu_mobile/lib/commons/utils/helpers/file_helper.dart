import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/utils/enums/file_extension_enum.dart";
import "package:falatu_mobile/commons/utils/enums/images_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:video_thumbnail/video_thumbnail.dart";

class FileHelper {
  static FalaTuImagesEnum getIconByFileExtension(FileExtensionsEnum extension) {
    switch (extension) {
      case FileExtensionsEnum.pdf:
        return FalaTuImagesEnum.pdfIcon;
      case FileExtensionsEnum.xls:
        return FalaTuImagesEnum.sheetsIcon;
      case FileExtensionsEnum.xlsx:
        return FalaTuImagesEnum.sheetsIcon;
      case FileExtensionsEnum.doc:
        return FalaTuImagesEnum.docIcon;
      case FileExtensionsEnum.docx:
        return FalaTuImagesEnum.docIcon;
      case FileExtensionsEnum.txt:
        return FalaTuImagesEnum.txtIcon;
      case FileExtensionsEnum.csv:
        return FalaTuImagesEnum.sheetsIcon;
    }
  }

  static String bytesConverter(int bytes) {
    double result = 0;
    if (bytes >= 1000 && bytes < 1000000) {
      result = bytes / 1024;
      return "${result.toStringAsFixed(0)} KB";
    } else if (bytes >= 1000000) {
      result = bytes / 1048576;
      return "${result.toStringAsFixed(2)} MB";
    } else {
      return "$bytes bytes";
    }
  }

  static String getFileExtension(String path) {
    final String result = path.split(".").last;
    return result;
  }

  static String formatFileName(String id,
      {int index = 0, String documentExtension = ""}) {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = id.substring(0, 5) +
        time.substring(4) +
        index.toString() +
        documentExtension;
    return fileName;
  }

  static Future<XFile?> getVideoThumbnail(String videoPath) async {
    String? path = await VideoThumbnail.thumbnailFile(
        video: videoPath, imageFormat: ImageFormat.JPEG);
    return path.let((e) => XFile(e));
  }
}
