import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuth = LocalAuthentication();

  User? get currentUser => _auth.currentUser;

  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      bool canAuthenticate = await _localAuth.canCheckBiometrics;
      if (!canAuthenticate) return false;

      return await _localAuth.authenticate(
        localizedReason: 'Autentique-se para registrar o ponto',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
