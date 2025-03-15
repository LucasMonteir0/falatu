import "package:image_picker/image_picker.dart";

abstract class FileService {
  Future<XFile?> fileFromUrl(String url);
}
