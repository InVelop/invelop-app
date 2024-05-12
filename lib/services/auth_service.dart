import 'package:firebase_auth/firebase_auth.dart';

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

  Future<String?> signUser({required email, required password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      print("Error on signUser ${error}");
      return error.message;
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
