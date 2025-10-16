import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/company_service.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final Company? company;

  const LoginScreen({super.key, this.company});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _nifController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegisterScreen(company: widget.company),
                  ),
                );
              },
              child: const Text('Register'),
            ),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  void _login() async {
    String nif = _nifController.text.trim();
    String password = _passwordController.text.trim();

    if (nif.isEmpty || password.isEmpty) {
      setState(() {
        _error = 'Please fill in all fields';
      });
      return;
    }

    if (widget.company == null) {
      setState(() {
        _error = 'No company selected';
      });
      return;
    }

    var user = await _auth.signInWithNifAndPassword(
      nif,
      password,
      widget.company!.id,
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(company: widget.company!),
        ),
      );
    } else {
      setState(() {
        _error = 'Invalid NIF or password';
      });
    }
  }
}
