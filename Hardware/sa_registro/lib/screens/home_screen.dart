import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/auth_service.dart';
import '../services/geolocation_service.dart';
import '../services/firestore_service.dart';
import '../services/company_service.dart';
import 'login_screen.dart';
import 'checkin_history_screen.dart';

class HomeScreen extends StatefulWidget {
  final Company company;

  const HomeScreen({super.key, required this.company});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  final GeolocationService _geoService = GeolocationService();
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
            Text(
              'Company: ${widget.company.name}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
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

    bool isWithinWorkplace = await _geoService.isWithinWorkplace(
      widget.company,
    );
    if (!isWithinWorkplace) {
      setState(() {
        _isLoading = false;
        _message = 'You are not within 100 meters of the workplace.';
      });
      return;
    }

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
