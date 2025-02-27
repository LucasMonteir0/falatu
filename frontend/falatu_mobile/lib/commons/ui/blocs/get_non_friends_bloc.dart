import "package:falatu_mobile/commons/core/domain/entities/user_entity.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_non_friends/get_non_friends_use_case.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class GetNonFriendsBloc extends Cubit<BaseState> {
  final GetNonFriendsUseCase _useCase;

  GetNonFriendsBloc(this._useCase) : super(const InitialState());

  void call() async {
    emit(LoadingState());

    final result = await _useCase.call();
    if (result.success) {
      emit(SuccessState<List<UserEntity>>(result.data!));
    } else {
      emit(ErrorState(result.error));
    }
  }
}
