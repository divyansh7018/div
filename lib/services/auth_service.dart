import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> login({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  Future<UserCredential> register({required String name, required String email, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    await credential.user?.updateDisplayName(name.trim());
    return credential;
  }

  Future<void> logout() => _auth.signOut();
}
