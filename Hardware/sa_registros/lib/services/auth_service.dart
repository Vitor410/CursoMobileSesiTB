import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  AuthService() {
    _auth.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  Future<String?> signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } catch (e) {
      return _getErrorMessage(e);
    }
  }

  Future<String?> createUserWithEmailPassword(
    String email,
    String password,
  ) async {
    // Validação de entrada
    if (email.isEmpty || password.isEmpty) {
      return 'Email e senha são obrigatórios.';
    }

    if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }

    // Validação básica de email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Por favor, insira um email válido.';
    }

    try {
      // Criar usuário no Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Verificar se o usuário foi criado com sucesso
      if (userCredential.user != null) {
        notifyListeners();
        return null; // Sucesso
      } else {
        return 'Falha ao criar conta. Tente novamente.';
      }
    } catch (e) {
      return _getErrorMessage(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  String _getErrorMessage(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Este email já está sendo usado por outra conta.';
        case 'weak-password':
          return 'A senha deve ter pelo menos 6 caracteres.';
        case 'invalid-email':
          return 'Email inválido.';
        case 'user-not-found':
          return 'Usuário não encontrado.';
        case 'wrong-password':
          return 'Senha incorreta.';
        case 'too-many-requests':
          return 'Muitas tentativas. Tente novamente mais tarde.';
        case 'operation-not-allowed':
          return 'Operação não permitida. Verifique as configurações do Firebase.';
        case 'network-request-failed':
          return 'Erro de rede. Verifique sua conexão com a internet.';
        default:
          return 'Erro de autenticação: ${e.message ?? e.code}';
      }
    }
    return 'Erro inesperado: ${e.toString()}';
  }
}
