import "package:cross_file/cross_file.dart";

enum ShareServiceResultStatus {
  success,
  dismissed,
  unavailable;

  static ShareServiceResultStatus getStatusByName(String name) {
    return ShareServiceResultStatus.values
        .firstWhere((e) => e.name == name, orElse: () => unavailable);
  }
}

class ShareServiceResult {
  final String raw;
  final ShareServiceResultStatus status;

  ShareServiceResult({required this.raw, required this.status});
}

abstract class ShareService {
  Future<ShareServiceResult> files({
    required XFile file,
    String? subject,
    String? text,
    String? fileNameOverrides,
  });
}
