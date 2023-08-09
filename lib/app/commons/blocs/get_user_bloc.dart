import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/usecases/user/user_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Cubit<BaseState> {
  GetUserBloc(this._useCase) : super(EmptyState());

  final UserUseCase _useCase;

  Future<void> call() async {
    emit(LoadingState());
    try {
      final result = await _useCase.getUser();
      emit(SuccessState(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }
}
