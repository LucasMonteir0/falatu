import "package:falatu_mobile/commons/core/domain/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:file_picker/file_picker.dart";
import "package:image_picker/image_picker.dart";

class FilePickerServiceImpl implements FilePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  FilePickerServiceImpl();

  @override
  Future<XFile?> document({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await _filePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    return result.let((file) => file.xFiles.first);
  }

  @override
  Future<XFile?> imageFromCamera() async {
    return await _imagePicker.pickImage(source: ImageSource.camera);
  }

  @override
  Future<XFile?> imageFromGallery() async {
    return await _imagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<List<XFile>> multipleImagesFromGallery() async {
    return await _imagePicker.pickMultiImage();
  }

  @override
  Future<XFile?> videoFromCamera() async {
    return await ImagePicker().pickVideo(source: ImageSource.camera);
  }

  @override
  Future<XFile?> videoFromGallery() async {
    return await ImagePicker().pickVideo(source: ImageSource.gallery);
  }
}
