import "dart:io";

import "package:falatu_mobile/commons/core/data/services/file_picker_service/file_picker_service.dart";
import "package:image_picker/image_picker.dart";

class FilePickerServiceImpl implements FilePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  FilePickerServiceImpl();

  @override
  Future<File?> document() {
    // TODO: implement document
    throw UnimplementedError();
  }

  @override
  Future<File?> imageFromCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }

  @override
  Future<File?> imageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  @override
  Future<List<File>> multipleImagesFromGallery() async {
    final result = await _imagePicker.pickMultiImage();
    return result.map((e) => File(e.path)).toList();
  }

  @override
  Future<File?> videoFromCamera() {
    // TODO: implement videoFromCamera
    throw UnimplementedError();
  }

  @override
  Future<File?> videoFromGallery() {
    // TODO: implement videoFromGallery
    throw UnimplementedError();
  }
}
