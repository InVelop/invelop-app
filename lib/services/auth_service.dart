import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerUser({required email, required password}) {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      print("Error on registerUser ${error}");
    }
  }

  Future<String?> signUser({required email, required password}) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }

  Future<void> logout() async {
    _firebaseAuth.signOut();
  }
}
