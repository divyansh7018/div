import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> upsertUserProfile(AppUser user) {
    return _firestore.collection('users').doc(user.uid).set(user.toJson(), SetOptions(merge: true));
  }

  Future<AppUser?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return AppUser.fromJson(doc.data()!);
  }
}
