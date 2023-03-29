import 'package:falatu/modules/chat/core/data/datasources/local/get_files_datasource/get_files_datasource.dart';
import 'package:falatu/modules/chat/core/data/datasources/local/get_files_datasource/get_files_datasource_impl.dart';
import 'package:falatu/modules/chat/core/data/repositories/get_files_repository/get_files_repository_impl.dart';
import 'package:falatu/modules/chat/core/domains/repositories/get_files_repository/get_files_repository.dart';
import 'package:falatu/modules/chat/core/domains/usecases/get_files_usecase/get_files_usecase.dart';
import 'package:falatu/modules/chat/core/domains/usecases/get_files_usecase/get_files_usecase_impl.dart';
import 'package:falatu/modules/chat/ui/blocs/get_files_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    // Put here yours DATASOURCES
    Bind.factory<GetFilesDatasource>((i) => ImagePickerDatasourceImpl(i())),

    // Put here yours REPOSITORIES
    Bind.factory<GetFilesRepository>((i) => GetFilesRepositoryImpl(i())),

    // Put here yours USECASES
    Bind.factory<GetFilesUseCase>((i) => GetFilesUseCaseImpl(i())),

    // Put here yours BLOCS
    Bind.factory<GetImageFromGalleryBloc>((i) => GetImageFromGalleryBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [];
}