import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService, this._firestoreService) {
    _subscription = _authService.authStateChanges().listen(_onAuthChanged);
  }

  final AuthService _authService;
  final FirestoreService _firestoreService;

  StreamSubscription<User?>? _subscription;
  AppUser? _user;
  bool _isLoading = false;
  String? _error;

  AppUser? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _onAuthChanged(User? fbUser) async {
    if (fbUser == null) {
      _user = null;
      notifyListeners();
      return;
    }

    try {
      final remoteProfile = await _firestoreService.getUserProfile(fbUser.uid);
      _user = remoteProfile ??
          AppUser(
            uid: fbUser.uid,
            name: fbUser.displayName ?? 'Learner',
            email: fbUser.email ?? '',
          );
      await _firestoreService.upsertUserProfile(_user!);
    } catch (_) {
      _user = AppUser(uid: fbUser.uid, name: fbUser.displayName ?? 'Learner', email: fbUser.email ?? '');
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _authService.login(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message ?? 'Login failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final cred = await _authService.register(name: name, email: email, password: password);
      final user = AppUser(uid: cred.user!.uid, name: name.trim(), email: email.trim());
      await _firestoreService.upsertUserProfile(user);
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message ?? 'Registration failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
