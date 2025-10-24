import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/firebase_service.dart';
import '../widgets/custom_button.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final LocationService _locationService = LocationService();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  String _status = 'Verificando localização...';

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  Future<void> _checkLocation() async {
    final position = await _locationService.getCurrentPosition();
    if (position != null) {
      bool withinRange = _locationService.isWithinRange(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _status = withinRange ? 'Dentro da área' : 'Fora da área';
      });
    } else {
      setState(() {
        _status = 'Erro ao obter localização';
      });
    }
  }

  Future<void> _registrarPonto() async {
    final user = context.read<AuthService>().currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao obter localização')),
      );
      setState(() => _isLoading = false);
      return;
    }

    bool withinRange = _locationService.isWithinRange(
      position.latitude,
      position.longitude,
    );
    if (!withinRange) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Você deve estar dentro de 100m do local de trabalho'),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      await _firebaseService.saveRegistro(
        user.uid,
        user.email ?? 'Usuário',
        position.latitude,
        position.longitude,
        DateTime.now(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ponto registrado!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao registrar ponto')));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Data: ${DateTime.now().toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Hora: ${DateTime.now().toLocal().toString().split(' ')[1].split('.')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Status: $_status',
              style: TextStyle(
                fontSize: 16,
                color: _status == 'Dentro da área' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 40),
            if (_isLoading) const CircularProgressIndicator(),
            CustomButton(
              text: 'Registrar Ponto',
              onPressed: _isLoading ? null : _registrarPonto,
            ),
          ],
        ),
      ),
    );
  }
}
