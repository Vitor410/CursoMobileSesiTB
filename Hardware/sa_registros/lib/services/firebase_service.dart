import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveRegistro(
    String userId,
    String nome,
    double latitude,
    double longitude,
    DateTime timestamp,
  ) async {
    await _firestore.collection('registros').add({
      'userId': userId,
      'nome': nome,
      'data': timestamp.toIso8601String().split('T')[0],
      'hora': timestamp.toIso8601String().split('T')[1].split('.')[0],
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> getRegistros(String userId) {
    return _firestore
        .collection('registros')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
