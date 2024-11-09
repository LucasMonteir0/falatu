import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/commons/blocs/get_files_bloc.dart';
import 'package:falatu/app/core/data/datasources/remote/auth/auth_datasource.dart';
import 'package:falatu/app/core/data/datasources/remote/auth/firebase_auth_datasource_impl.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/chat_datasource.dart';
import 'package:falatu/app/core/data/datasources/remote/chat/firebase_chat_datasource_impl.dart';
import 'package:falatu/app/core/data/datasources/remote/user/user_datasource_impl.dart';
import 'package:falatu/app/core/data/repositories/chat/chat_repository_impl.dart';
import 'package:falatu/app/core/data/repositories/user/user_repository_impl.dart';
import 'package:falatu/app/core/domains/repositories/chat/chat_repository.dart';
import 'package:falatu/app/core/domains/usecases/auth/login/login_use_case.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_chat_messages_use_case.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_chat_messages_use_case_impl.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_private_chats_use_case.dart';
import 'package:falatu/app/core/domains/usecases/chat/get_private_chats_use_case_impl.dart';
import 'package:falatu/app/core/domains/usecases/chat/messages/send_chat_message_use_case.dart';
import 'package:falatu/app/core/domains/usecases/chat/messages/send_chat_message_use_case_impl.dart';
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
import 'package:falatu/app/presentation/chat/blocs/messages/get_chat_messages_bloc.dart';
import 'package:falatu/app/presentation/chat/blocs/messages/send_chat_message_bloc.dart';
import 'package:falatu/app/presentation/chat/blocs/private_chats/get_private_chats_bloc.dart';
import 'package:falatu/app/presentation/chat/view/home_page.dart';
import 'package:falatu/app/commons/blocs/get_user_bloc.dart';
import 'package:falatu/app/presentation/chat/view/private_chat_page.dart';
import 'package:falatu/app/presentation/splash/blocs/verify_auth_user_bloc.dart';
import 'package:falatu/app/presentation/splash/splash_page.dart';
import 'package:falatu/app/commons/config/app_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // Put here your EXTERNAL DEPENDENCIES
        Bind.instance<FilePicker>(FilePicker.platform),
        Bind.instance<FirebaseFirestore>(FirebaseFirestore.instance),
        Bind.instance<FirebaseAuth>(FirebaseAuth.instance),
        Bind.instance<FirebaseStorage>(FirebaseStorage.instance),

        // Put here your DATASOURCES
        Bind.factory<UserDatasource>((i) => UserDatasourceImpl(i(), i())),
        Bind.factory<AuthDatasource>(
            (i) => FirebaseAuthDatasourceImpl(i(), i())),
        Bind.factory<ChatDatasource>((i) => FirebaseChatDatasourceImpl(i(), i())),

        // Put here your REPOSITORIES
        Bind.factory<UserRepository>((i) => UserRepositoryImpl(i())),
        Bind.factory<AuthRepository>((i) => AuthRepositoryImpl(i())),
        Bind.factory<ChatRepository>((i) => ChatRepositoryImpl(i())),

        // Put here your USECASES
        Bind.factory<UserUseCase>((i) => UserUseCaseImpl(i())),
        Bind.factory<LoginUseCase>((i) => LoginUseCaseImpl(i())),
        Bind.factory<RegisterUserUseCase>((i) => RegisterUserUseCaseImpl(i())),
        Bind.factory<SignOutUseCase>((i) => SignOutUseCaseImpl(i())),
        Bind.factory<GetPrivateChatsUseCase>(
            (i) => GetPrivateChatsUseCaseImpl(i())),
        Bind.factory<GetChatMessagesUseCase>(
            (i) => GetChatMessagesUseCaseImpl(i())),
        Bind.factory<SendChatMessageUseCase>(
            (i) => SendChatMessageUseCaseImpl(i())),

        // Put here your BLOCS
        Bind.factory<VerifyAuthUserBloc>((i) => VerifyAuthUserBloc(i())),
        Bind.lazySingleton<GetUserBloc>((i) => GetUserBloc(i())),
        Bind.factory<RegisterUserBloc>((i) => RegisterUserBloc(i())),
        Bind.factory<LoginBloc>((i) => LoginBloc(i())),
        Bind.factory<SignOutBloc>((i) => SignOutBloc(i())),
        Bind.factory<SendChatMessageBloc>((i) => SendChatMessageBloc(i())),
        Bind.lazySingleton<GetPrivateChatsBloc>((i) => GetPrivateChatsBloc(i())),
        Bind.factory<GetChatMessagesBloc>((i) => GetChatMessagesBloc(i())),
        Bind.factory<GetFilesBloc>((i) => GetFilesBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(AppRoutes.root,
            child: (context, _) => const SplashScreen()),
        ChildRoute(
          AppRoutes.login,
          child: (context, args) => LoginPage(isSignOut: args.data),
        ),
        ChildRoute(
          AppRoutes.signUp,
          child: (context, _) => const SignUpPage(),
        ),
        ChildRoute(
          AppRoutes.home,
          child: (context, _) => const HomePage(),
        ),
        ChildRoute(
          AppRoutes.chat,
          child: (context, args) => PrivateChatPage(params: args.data),
        ),
      ];
}

