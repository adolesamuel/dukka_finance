import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestorePath {
  static String dashboardData(String uid) => 'dashboard/$uid';
}

final appDatabaseProvider =
    Provider.autoDispose<AppDataBase>((ref) => AppDataBase());

class AppDataBase {
  AppDataBase();
  final FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<void> createDashBoard(AppUser user) async {
    print("uid: ${user.uid}");
    final emptyDashboard = DashboardData(
      id: user.uid,
      balance: 0.0,
      email: user.email,
      fullName: user.fullName,
    );
    ref.doc(FirestorePath.dashboardData(user.uid)).set(emptyDashboard.toJson());
  }

  Stream<Map<String, dynamic>?> streamDashBoardData(AppUser user) async* {
    print(user.fullName);
    yield* ref
        .doc(FirestorePath.dashboardData(user.uid))
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
}
