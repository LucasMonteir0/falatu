import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/modules/auth/ui/blocs/isign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController implements ISignUpController {
  @override
  Future<String?> registerUser(
      String email, String password, String firstName) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Envia a verificacao de email
        userCredential.user!.sendEmailVerification();


        // Salve o usuário no Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': email,
          'firstName': firstName,
        });
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
