import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorePath {
  static String dashboardData(String uid) => 'dashboard/$uid';
}

class AppDataBase {
  AppDataBase._();
  static final instance = AppDataBase._();
  //
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  String email = FirebaseAuth.instance.currentUser?.email ?? '';
  String fullName = FirebaseAuth.instance.currentUser?.displayName ?? '';
  FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<void> createDashBoard() async {
    print("uid: $uid");
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
