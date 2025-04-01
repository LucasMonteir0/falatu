import "package:dio/dio.dart";
import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource.dart";
import "package:falatu_mobile/commons/core/data/datasources/auth/auth_commons_datasource_impl.dart";
import "package:falatu_mobile/commons/core/data/datasources/users/users_commons_datasource.dart";
import "package:falatu_mobile/commons/core/data/datasources/users/users_commons_datasource_impl.dart";
import "package:falatu_mobile/commons/core/data/repositories/auth/auth_commons_repository_impl.dart";
import "package:falatu_mobile/commons/core/data/repositories/users/users_commons_repository_impl.dart";
import "package:falatu_mobile/commons/core/data/services/file_picker_service/file_picker_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/file_service/file_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/http_service/http_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/share_service/share_service_impl.dart";
import "package:falatu_mobile/commons/core/data/services/shared_preferences_services/shared_preferences_services_impl.dart";
import "package:falatu_mobile/commons/core/data/services/socket_io_service/socket_io_service_impl.dart";
import "package:falatu_mobile/commons/core/domain/repositories/auth/auth_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/repositories/users/users_commons_repository.dart";
import "package:falatu_mobile/commons/core/domain/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/core/domain/services/file_service/file_service.dart";
import "package:falatu_mobile/commons/core/domain/services/http_service/http_service.dart";
import "package:falatu_mobile/commons/core/domain/services/share_service/share_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/core/domain/services/socket_io_service/socket_io_service.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_non_friends/get_non_friends_use_case.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_non_friends/get_non_friends_use_case_impl.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_user/get_user_use_case.dart";
import "package:falatu_mobile/commons/core/domain/usecases/get_user/get_user_use_case_impl.dart";
import "package:falatu_mobile/commons/core/domain/usecases/sign_out/sign_out_use_case.dart";
import "package:falatu_mobile/commons/core/domain/usecases/sign_out/sign_out_use_case_impl.dart";
import "package:falatu_mobile/commons/core/domain/usecases/update_access_token/update_access_token_use_case.dart";
import "package:falatu_mobile/commons/core/domain/usecases/update_access_token/update_access_token_use_case_impl.dart";
import "package:falatu_mobile/commons/ui/blocs/download_file_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/get_non_friends_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/get_user_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_files_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/sign_out_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/update_access_token_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class CommonsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        //SERVICES
        Bind.lazySingleton<FilePickerService>((i) => FilePickerServiceImpl(),
            export: true),
        Bind.lazySingleton<SharedPreferencesService>(
            (i) => SharedPreferencesServiceImpl(),
            export: true),
        Bind.factory<FileService>((i) => FileServiceImpl(i()), export: true),
        Bind.factory<ShareService>((i) => ShareServiceImpl(), export: true),
        Bind.lazySingleton<HttpService>(
            (i) => HttpServiceImpl(
                  Dio(),
                  i(),
                  onRefreshToken: () =>
                      Modular.get<UpdateAccessTokenBloc>().call(),
                  onSignOut: () => Modular.get<SignOutBloc>().call(),
                ),
            export: true),
        Bind.lazySingleton<SocketIoService>(
            (i) => SocketServiceIoImpl(
                  onRefreshToken: () async =>
                      await Modular.get<UpdateAccessTokenBloc>().call(),
                  preferences: i(),
                ),
            export: true),

        //DATASOURCES
        Bind.factory<AuthCommonsDatasource>(
            (i) => AuthCommonsDatasourceImpl(i(), i(),
                onNullRefreshToken: () => Modular.get<SignOutBloc>().call()),
            export: true),
        Bind.factory<UsersCommonsDatasource>(
            (i) => UsersCommonsDatasourceImpl(i(), i()),
            export: true),

        //REPOSITORIES
        Bind.factory<AuthCommonsRepository>(
            (i) => AuthCommonsRepositoryImpl(i()),
            export: true),
        Bind.factory<UsersCommonsRepository>(
            (i) => UsersCommonsRepositoryImpl(i()),
            export: true),

        //USECASES
        Bind.factory<UpdateAccessTokenUseCase>(
            (i) => UpdateAccessTokenUseCaseImpl(i()),
            export: true),
        Bind.factory<SignOutUseCase>((i) => SignOutUseCaseImpl(i()),
            export: true),
        Bind.factory<GetNonFriendsUseCase>((i) => GetNonFriendsUseCaseImpl(i()),
            export: true),
        Bind.factory<GetUserUseCase>((i) => GetUserUseCaseImpl(i()),
            export: true),

        //BLOCS
        Bind.lazySingleton<UpdateAccessTokenBloc>(
            (i) => UpdateAccessTokenBloc(i(), i()),
            export: true),
        Bind.lazySingleton<SignOutBloc>((i) => SignOutBloc(i()), export: true),
        Bind.lazySingleton<GetUserBloc>((i) => GetUserBloc(i()), export: true),
        Bind.factory<GetNonFriendsBloc>((i) => GetNonFriendsBloc(i()),
            export: true),
        Bind.factory<ShareFilesBloc>((i) => ShareFilesBloc(i()), export: true),
        Bind.factory<DownloadFileBloc>((i) => DownloadFileBloc(i(), i()),
            export: true),
      ];
}
