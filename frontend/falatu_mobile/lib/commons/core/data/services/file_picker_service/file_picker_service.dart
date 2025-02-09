import "dart:io";

abstract class FilePickerService {
  Future<File?> imageFromGallery();

  Future<File?> imageFromCamera();

  Future<File?> videoFromGallery();

  Future<File?> videoFromCamera();

  Future<List<File>> multipleImagesFromGallery();

  Future<File?> document();
}
