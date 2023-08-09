import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:falatu/app/core/data/datasources/remote/user/user_datasource.dart';
import 'package:falatu/app/core/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatasourceImpl implements UserDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  UserDatasourceImpl(this._firestore, this._firebaseAuth);

  @override
  Future<UserModel> getUser() async {
    try {
      final User? currentUser = _firebaseAuth.currentUser;
      DocumentSnapshot result =
          await _firestore.collection('users').doc(currentUser!.uid).get();
      final data = result.data() as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> verifyAuthUser() async {
    User? user = _firebaseAuth.currentUser;
    return user != null;
  }
}
