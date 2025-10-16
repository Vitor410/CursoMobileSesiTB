import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCheckIn(
    String userId,
    DateTime timestamp,
    double latitude,
    double longitude,
  ) async {
    await _db.collection('check_ins').add({
      'userId': userId,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
