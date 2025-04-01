import "package:falatu_mobile/commons/core/domain/entities/result_wrapper.dart";
import "package:image_picker/image_picker.dart";

abstract class FileService {
  Future<ResultWrapper<XFile>> fileFromUrl(String url);
}
