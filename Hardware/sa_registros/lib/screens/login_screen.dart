import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginWithEmailPassword() async {
    setState(() => _isLoading = true);
    String? error = await context.read<AuthService>().signInWithEmailPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    setState(() => _isLoading = false);
    if (error == null) {
      // Navigation handled by AuthWrapper
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Falha no login: $error')));
    }
  }

  Future<void> _createAccount() async {
    setState(() => _isLoading = true);
    try {
      String? error = await context
          .read<AuthService>()
          .createUserWithEmailPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      setState(() => _isLoading = false);
      if (error == null) {
        // Conta criada com sucesso - AuthWrapper irá navegar automaticamente
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta criada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha na criação da conta: $error')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro inesperado: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email/NIF'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            CustomButton(
              text: 'Entrar',
              onPressed: _isLoading ? null : _loginWithEmailPassword,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Criar Conta',
              onPressed: _isLoading
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    ),
              color: Colors.green,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
