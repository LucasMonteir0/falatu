import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/commons/core/domain/services/file_service/file_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class DownloadFileBloc extends Cubit<BaseState> {
  final FileService _service;
  final SharedPreferencesService _preferences;

  DownloadFileBloc(this._service, this._preferences)
      : super(const InitialState());

  void call(String url) async {
    emit(LoadingState());
    // final file = _preferences.getFile(url); //ESTE MeTODO DE SALVAR O ARQUIVO EM CACHE TRAVA A APLICAÇÃO.
    // if (file != null) {
    //   emit(SuccessState<XFile>(file));
    //   return;
    // }

    final result = await _service.fileFromUrl(url);
    if (result.success) {
      _preferences.setFile(url, result.data!.path);
      emit(SuccessState<XFile>(result.data!));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
