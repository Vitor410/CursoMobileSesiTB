import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  Company({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Company.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Company(
      id: doc.id,
      name: data['name'] ?? '',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
    );
  }
}

class CompanyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Company>> getCompanies() async {
    QuerySnapshot snapshot = await _db.collection('companies').get();
    return snapshot.docs.map((doc) => Company.fromFirestore(doc)).toList();
  }

  Future<void> addCompany(
    String name,
    double latitude,
    double longitude,
  ) async {
    await _db.collection('companies').add({
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
