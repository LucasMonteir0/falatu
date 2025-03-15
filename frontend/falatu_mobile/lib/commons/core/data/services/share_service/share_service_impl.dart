import "package:falatu_mobile/commons/core/domain/services/share_service/share_service.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:share_plus/share_plus.dart";

class ShareServiceImpl implements ShareService {
  @override
  Future<ShareServiceResult> files(
      {required List<XFile> files,
      String? subject,
      String? text,
      List<String>? fileNameOverrides}) async {
    Share.downloadFallbackEnabled = true;

    final share = await Share.shareXFiles(files,
        subject: subject,
        text: text,
        fileNameOverrides:
            fileNameOverrides ?? files.map((e) => e.fileName).toList());
    final result = ShareServiceResult(
      raw: share.raw,
      status: ShareServiceResultStatus.getStatusByName(share.status.name),
    );

    return result;
  }
}
