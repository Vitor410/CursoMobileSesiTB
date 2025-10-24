import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _error = '';
  bool _isDisposed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(onPressed: _register, child: const Text('Register')),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Login'),
            ),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      if (mounted && !_isDisposed) {
        setState(() {
          _error = 'Please fill in all fields';
        });
      }
      return;
    }

    if (password != confirmPassword) {
      if (mounted && !_isDisposed) {
        setState(() {
          _error = 'Passwords do not match';
        });
      }
      return;
    }

    var user = await _auth.registerWithEmailAndPassword(email, password);
    if (_isDisposed) return; // Check if disposed before proceeding

    if (user != null) {
      if (mounted && !_isDisposed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      if (mounted && !_isDisposed) {
        setState(() {
          _error = 'Registration failed';
        });
      }
    }
  }
}
