import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:falatu/app/core/domains/entities/user/user_entity.dart';
import 'package:falatu/app/core/domains/usecases/user/user_usercase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Cubit<BaseState> {
  GetUserBloc(this._useCase) : super(EmptyState());

  final UserUseCase _useCase;

  Future<void> call() async {
    emit(LoadingState());
    try {
      final UserEntity currentUser = await _useCase.getUser();
      final List<UserEntity> users = await _useCase.getAllUsers();
      final UsersReturn result =
          UsersReturn(currentUser: currentUser, users: users);
      emit(SuccessState<UsersReturn>(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }
}

class UsersReturn {
  final UserEntity currentUser;
  final List<UserEntity> users;

  UsersReturn({required this.currentUser, required this.users});
}
