import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'company_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signInWithNifAndPassword(
    String nif,
    String password,
    String companyId,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: '$nif@$companyId.com', // Using NIF@companyId as email
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> registerWithNifAndPassword(
    String nif,
    String password,
    String companyId,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: '$nif@$companyId.com',
        password: password,
      );
      // Store user company association
      await _db.collection('users').doc(result.user!.uid).set({
        'nif': nif,
        'companyId': companyId,
      });
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> getUserCompanyId() async {
    if (_auth.currentUser == null) return null;
    DocumentSnapshot doc = await _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    if (doc.exists) {
      return doc['companyId'];
    }
    return null;
  }

  Future<Company?> getUserCompany() async {
    String? companyId = await getUserCompanyId();
    if (companyId == null) return null;
    DocumentSnapshot doc = await _db
        .collection('companies')
        .doc(companyId)
        .get();
    if (doc.exists) {
      return Company.fromFirestore(doc);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
