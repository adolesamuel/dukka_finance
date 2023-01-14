import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorePath {
  static String setUserData() => 'users';
  static String getUserData(String uid) => 'users/$uid';
  static String dashboardData(String uid) => 'dashboard/$uid';
  static String setDashboardData(String uid) => 'dashboard/$uid';
}

class AppDataBase {
  AppDataBase._();
  static final instance = AppDataBase._();
  //
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String email = FirebaseAuth.instance.currentUser?.email ?? '';
  FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData() async {
    return await ref
        .doc(FirestorePath.getUserData(uid))
        .get()
        .then((value) => value.data());
  }

  Future<void> createUserData(String fullName, String id) async {
    ref.doc(FirestorePath.getUserData(id)).set({'full_name': fullName});
  }

  Future<void> createDashBoard() async {
    final fullName = (await getUserData())?['full_name'] ?? '';
    final emptyDashboard = DashboardData(
      id: uid,
      balance: 0.0,
      email: email,
      fullName: fullName,
    );
    ref.doc(FirestorePath.dashboardData(uid)).set(emptyDashboard.toJson());
  }

  Stream<Map<String, dynamic>?> streamDashBoardData() async* {
    yield* ref
        .doc(FirestorePath.dashboardData(uid))
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
}
