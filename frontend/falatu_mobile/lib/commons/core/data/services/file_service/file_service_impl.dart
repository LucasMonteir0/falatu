import "dart:io";
import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/core/domain/services/file_service/file_service.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/utils/extensions/string_extensions.dart";
import "package:path/path.dart" as path;
import "package:path_provider/path_provider.dart";

class FileServiceImpl implements FileService {
  final HttpService _http;

  FileServiceImpl(this._http);

  @override
  Future<XFile?> fileFromUrl(String url) async {
    try {
      Directory tempDir = await getTemporaryDirectory();

      String fileName = path.basename(Uri.parse(url).path.pathToName());
      String filePath = path.join(tempDir.path, fileName);

      final response = await _http.download(url, savePath: filePath);

      return response.data;
    } catch (e) {
      return null;
    }
  }
}
