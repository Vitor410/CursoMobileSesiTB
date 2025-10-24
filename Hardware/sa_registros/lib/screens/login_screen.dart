import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

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
    bool success = await context.read<AuthService>().signInWithEmailPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    setState(() => _isLoading = false);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Falha no login')));
    }
  }

  Future<void> _loginWithBiometrics() async {
    setState(() => _isLoading = true);
    bool success = await context
        .read<AuthService>()
        .authenticateWithBiometrics();
    setState(() => _isLoading = false);
    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha na autenticação biométrica')),
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
              text: 'Login Biométrico',
              onPressed: _isLoading ? null : _loginWithBiometrics,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
