import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/modules/auth/auth_module.dart';
import 'package:falatu/modules/chat/chat_module.dart';
import 'package:falatu/shared/config/auth_routes.dart';
import 'package:falatu/shared/config/chat_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        ChatModule(),
      ];

  @override
  List<Bind> get binds => [
        // Put here yours EXTERNAL DEPENDENCIES
        Bind.factory<ImagePicker>((i) => ImagePicker()),
    Bind.factory<FirebaseFirestore>((i) => FirebaseFirestore.instance),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(AuthRoutes.root, module: AuthModule()),
        ModuleRoute(ChatRoutes.root, module: AuthModule()),
      ];
}
