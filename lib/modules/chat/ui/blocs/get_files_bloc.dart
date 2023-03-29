import 'dart:io';
import 'package:falatu/modules/chat/core/domains/usecases/get_files_usecase/get_files_usecase.dart';
import 'package:falatu/shared/bloc_states/bloc_states.dart';
import 'package:bloc/bloc.dart';


// UM BLOC PARA CADA METODO / COMPORTAMENTO
class GetImageFromGalleryBloc extends Cubit<BaseState>{
  GetImageFromGalleryBloc(this.useCase) : super(EmptyState());

  final GetFilesUseCase useCase;

  void call(){
    emit(LoadingState());
    try {
      ///TODO METODO ASSINCRONO - MUDAR EM TODAS AS OUTRAS CAMADAS
      final result = useCase.getImagesFromGallery();
      emit(SuccessState<File>(result));

    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }



}