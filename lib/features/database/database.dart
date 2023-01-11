import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseProvider = Provider((ref) => FirebaseFirestore.instance);

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  final dat = ref.read(firebaseProvider);

  // we only have a valid DB if the user is signed in
  if (auth.value?.uid != null) {
    return FirestoreDatabase(uid: auth.value!.uid, firestoreDatabase: dat);
  }
  // else we return null
  return null;
});

class FirestoreDatabase {
  FirestoreDatabase({
    required this.uid,
    required this.firestoreDatabase,
  });
  final String uid;
  final FirebaseFirestore firestoreDatabase;
}
