import "package:cross_file/cross_file.dart";

abstract class FilePickerService {
  Future<XFile?> imageFromGallery();

  Future<XFile?> imageFromCamera();

  Future<XFile?> videoFromGallery();

  Future<XFile?> videoFromCamera();

  Future<List<XFile>> multipleImagesFromGallery();

  Future<XFile?> document();
}
