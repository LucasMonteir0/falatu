import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/core/domain/services/share_service/share_service.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ShareFilesBloc extends Cubit<ShareState> {
  final ShareService _share;

  ShareFilesBloc(this._share) : super(ShareInitialState());

  void call({
    required XFile file,
    String? subject,
    String? text,
    String? fileNameOverrides,
  }) async {
    emit(ShareLoadingState());
    final result = await _share.files(
        file: file,
        subject: subject,
        text: text,
        fileNameOverrides: fileNameOverrides);
    emit(ShareDoneState(result));
  }
}
