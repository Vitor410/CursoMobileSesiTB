import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/company_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Company? company;

  const RegisterScreen({super.key, this.company});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _nifController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.company != null)
              Text(
                'Company: ${widget.company!.name}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nifController,
              decoration: const InputDecoration(
                labelText: 'NIF',
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

  void _register() async {
    String nif = _nifController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (nif.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _error = 'Please fill in all fields';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _error = 'Passwords do not match';
      });
      return;
    }

    if (widget.company == null) {
      setState(() {
        _error = 'No company selected';
      });
      return;
    }

    var user = await _auth.registerWithNifAndPassword(
      nif,
      password,
      widget.company!.id,
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(company: widget.company),
        ),
      );
    } else {
      setState(() {
        _error = 'Registration failed';
      });
    }
  }
}
