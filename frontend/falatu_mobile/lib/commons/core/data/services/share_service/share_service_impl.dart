import "package:falatu_mobile/commons/core/domain/services/share_service/share_service.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/nullable_extensions.dart";
import "package:open_filex/open_filex.dart";
import "package:share_plus/share_plus.dart";

class ShareServiceImpl implements ShareService {
  @override
  Future<ShareServiceResult> files(
      {required XFile file,
      bool tryOpen = true,
      String? subject,
      String? text,
      String? fileNameOverrides}) async {
    Share.downloadFallbackEnabled = true;

    if (tryOpen) {
      final openResult = await OpenFilex.open(file.path);
      if (openResult.type == ResultType.done) {
        return ShareServiceResult(
          raw: openResult.message,
          status: ShareServiceResultStatus.success,
        );
      }
    }
    final share = await Share.shareXFiles([file],
        subject: subject,
        text: text,
        fileNameOverrides:
            fileNameOverrides.let((e) => [e]) ?? [file.fileName]);
    final result = ShareServiceResult(
      raw: share.raw,
      status: ShareServiceResultStatus.getStatusByName(share.status.name),
    );

    return result;
  }
}
