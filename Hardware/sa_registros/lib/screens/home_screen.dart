import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import 'registro_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Ponto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, ${user?.email ?? 'Usuário'}'),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Registrar Ponto',
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegistroScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
