import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'login_screen.dart';
import 'checkin_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  bool _isChecked = false;
  bool _isLoading = false;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check In'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckInHistoryScreen(),
                ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Check the box to confirm your check-in',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isChecked && !_isLoading ? _checkIn : null,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Check In'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _message,
              style: TextStyle(
                color: _message.contains('success') ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _checkIn() async {
    setState(() {
      _isLoading = true;
      _message = '';
    });

    // For now, skip geolocation check since no company is selected
    // In a real app, you might have a default company or user selection

    Position position = await Geolocator.getCurrentPosition();
    await _firestoreService.saveCheckIn(
      _auth.currentUser!.uid,
      DateTime.now(),
      position.latitude,
      position.longitude,
    );

    setState(() {
      _isLoading = false;
      _message = 'Check-in successful!';
      _isChecked = false;
    });
  }
}
