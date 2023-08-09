import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/core/data/datasources/remote/auth/auth_datasource.dart';
import 'package:falatu/app/core/data/datasources/remote/auth/firebase_auth_datasource_impl.dart';
import 'package:falatu/app/core/data/datasources/remote/user/user_datasource_impl.dart';
import 'package:falatu/app/core/data/repositories/user/user_repository_impl.dart';
import 'package:falatu/app/core/domains/usecases/auth/login/login_use_case.dart';
import 'package:falatu/app/presentation/auth/view/sign_up/sign_up_page.dart';
import 'package:falatu/app/core/data/datasources/remote/user/user_datasource.dart';
import 'package:falatu/app/core/data/repositories/auth/user_auth_repository_impl.dart';
import 'package:falatu/app/core/domains/repositories/auth/user_auth_repository.dart';
import 'package:falatu/app/core/domains/repositories/user/user_repository.dart';
import 'package:falatu/app/core/domains/usecases/auth/login/login_use_case_impl.dart';
import 'package:falatu/app/core/domains/usecases/auth/register/register_user_use_case.dart';
import 'package:falatu/app/core/domains/usecases/auth/register/register_user_use_case_impl.dart';
import 'package:falatu/app/core/domains/usecases/auth/sign_out/sign_out_use_case.dart';
import 'package:falatu/app/core/domains/usecases/auth/sign_out/sign_out_use_case_impl.dart';
import 'package:falatu/app/core/domains/usecases/user/user_usercase.dart';
import 'package:falatu/app/core/domains/usecases/user/user_usercase_impl.dart';
import 'package:falatu/app/presentation/auth/blocs/login_bloc.dart';
import 'package:falatu/app/presentation/auth/blocs/register_user_bloc.dart';
import 'package:falatu/app/presentation/auth/blocs/sign_out_bloc.dart';
import 'package:falatu/app/presentation/auth/view/login/login_page.dart';
import 'package:falatu/app/presentation/chat/view/chat_home_page.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/presentation/splash/blocs/verify_auth_user_bloc.dart';
import 'package:falatu/app/presentation/splash/splash_page.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // Put here your EXTERNAL DEPENDENCIES
        Bind.instance<ImagePicker>(ImagePicker()),
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),

        // Put here your DATASOURCES
        Bind.factory<UserDatasource>((i) => UserDatasourceImpl(i(), i())),
        Bind.factory<AuthDatasource>(
            (i) => FirebaseAuthDatasourceImpl(i(), i())),

        // Put here your REPOSITORIES
        Bind.factory<UserRepository>((i) => UserRepositoryImpl(i())),
        Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i())),

        // Put here your USECASES
        Bind.factory<UserUseCase>((i) => UserUseCaseImpl(i())),
        Bind.factory<LoginUseCase>((i) => LoginUseCaseImpl(i())),
        Bind.factory<RegisterUserUseCase>((i) => RegisterUserUseCaseImpl(i())),
        Bind.factory<SignOutUseCase>((i) => SignOutUseCaseImpl(i())),

        // Put here your BLOCS
        Bind.factory<VerifyAuthUserBloc>((i) => VerifyAuthUserBloc(i())),
        Bind.lazySingleton<GetUserBloc>((i) => GetUserBloc(i())),
        Bind.factory<RegisterUserBloc>((i) => RegisterUserBloc(i())),
        Bind.factory<LoginBloc>((i) => LoginBloc(i())),
        Bind.factory<SignOutBloc>((i) => SignOutBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.root,
            child: (context, args) => const SplashScreen()),
        ChildRoute(
          AppRoutes.login,
          child: (context, args) => LoginPage(isSignOut: args.data),
        ),
        ChildRoute(
          AppRoutes.signUp,
          child: (context, args) => const SignUpPage(),
        ),
        ChildRoute(
          AppRoutes.home,
          child: (context, args) => const ChatHomePage(),
        ),
      ];
}
