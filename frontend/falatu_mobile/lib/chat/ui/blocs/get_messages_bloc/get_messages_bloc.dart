import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class GetMessagesBloc extends Cubit<BaseState> {
  GetMessagesBloc() : super(const InitialState());
}
