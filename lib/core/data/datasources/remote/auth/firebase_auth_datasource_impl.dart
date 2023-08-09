import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/core/data/datasources/remote/auth/auth_datasource.dart';
import 'package:falatu/core/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthDatasourceImpl(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<String?> registerUser(String email, String password, String firstName,
      String lastName, String pictureUrl) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userModel = UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        picture: pictureUrl,
        id: userCredential.user!.uid,
      );
      if (userCredential.user != null) {
        // Envia a verificacao de email
        userCredential.user!.sendEmailVerification();

        // Salva o usuário no Firestore
        await _firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
              userModel.toJson(),
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

  @override
  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    if (_firebaseAuth.currentUser != null) {
      try {
        await _firebaseAuth.signOut();
        print('Usuário Deslogado');
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    }
  }


}
