import 'package:falatu/app/commons/bloc_states/bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadInitialDataBloc extends Cubit<BaseState>{
  LoadInitialDataBloc() : super(EmptyState());

  Future<void> call() async {

  }

}