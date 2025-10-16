import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class CheckInHistoryScreen extends StatefulWidget {
  const CheckInHistoryScreen({super.key});

  @override
  _CheckInHistoryScreenState createState() => _CheckInHistoryScreenState();
}

class _CheckInHistoryScreenState extends State<CheckInHistoryScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-In History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('check_ins')
            .where('userId', isEqualTo: _auth.currentUser!.uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading history'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final checkIns = snapshot.data!.docs;

          if (checkIns.isEmpty) {
            return const Center(child: Text('No check-ins found'));
          }

          return ListView.builder(
            itemCount: checkIns.length,
            itemBuilder: (context, index) {
              final checkIn = checkIns[index];
              final data = checkIn.data() as Map<String, dynamic>;
              final timestamp = (data['timestamp'] as Timestamp).toDate();
              final latitude = data['latitude'];
              final longitude = data['longitude'];

              return ListTile(
                title: Text('Check-in at ${timestamp.toString()}'),
                subtitle: Text('Location: $latitude, $longitude'),
              );
            },
          );
        },
      ),
    );
  }
}
