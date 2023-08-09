import 'package:falatu/core/domains/usecases/user/user_usercase.dart';
import 'package:falatu/commons/bloc_states/bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Cubit<BaseState> {
  GetUserBloc(this.useCase) : super(EmptyState());

  final UserUseCase useCase;

  Future<void> call() async {
    emit(LoadingState());
    try {
      final result = await useCase.getUser();
      emit(SuccessState(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }
}
