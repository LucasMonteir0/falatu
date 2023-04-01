import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/modules/auth/core/data/datasources/remote/user_auth/user_auth_datasource.dart';
import 'package:falatu/modules/auth/core/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasourceImpl implements UserAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseAuthDatasourceImpl(this.firebaseAuth, this.firebaseFirestore);

  @override
  Future<String?> registerUser(String email, String password, String firstName,
      String lastName, String pictureUrl) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Envia a verificacao de email
        userCredential.user!.sendEmailVerification();

        // Salve o usuário no Firestore
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          UserModel(
              email: email,
              firstName: firstName,
              lastName: lastName,
              picture: pictureUrl).toJson(),
        );
      }

      return 'Usuário cadastrado com sucesso!';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha é muito fraca';
      } else if (e.code == 'email-already-in-use') {
        return 'Este email já está em uso';
      } else {
        return 'Erro ao registrar o usuário';
      }
    } catch (e) {
      return 'Erro ao registrar o usuário';
    }
  }
}
