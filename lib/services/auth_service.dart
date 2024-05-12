import 'package:firebase_auth/firebase_auth.dart';
import 'package:invelop/models/user_model.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerUser({required email, required password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print("Error on registerUser ${error}");
    }
  }

  Future<UserCredential?> signUser({required email, required password}) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      print(credentials);
      print("========================");
      print(credentials.user);
      print("========================");
      print(credentials.user?.displayName);
      print(credentials.user?.uid);

      // Get the user data
      if (credentials.user != null) {
        return credentials;
      }

      return null;
    } on FirebaseAuthException catch (error) {
      print("Error on signUser ${error}");
      // return error.message;
      return null;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
