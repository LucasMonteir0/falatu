import 'package:bloc/bloc.dart';
import 'package:falatu/modules/auth/core/domains/usecases/user_auth/user_auth_usecase.dart';
import 'package:falatu/shared/bloc_states/bloc_states.dart';
import 'package:flutter/material.dart';

class RegisterUserController extends Cubit<BaseState> {
  RegisterUserController(this.useCase) : super(EmptyState());

  final UserAuthUseCase useCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final emailConfirmController = TextEditingController();
  final passwodController = TextEditingController();
  final passwodConfirmController = TextEditingController();
  final String userPhoto = '';

  void call(String email, String password, String firstName, String lastName, String picture){
    picture = userPhoto;
    emit(LoadingState());
    try {
    final result = useCase.registerUser(email, password, firstName, lastName, picture);
    emit(SuccessState(result));
    } catch (e){
      emit(ErrorState(e.toString()));
    }

  }
}