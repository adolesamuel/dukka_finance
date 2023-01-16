import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestorePath {
  static String dashboardData(String uid) => 'dashboard/$uid';
  static String transactionData(String uid) => 'users/$uid/transactions';
  static String debtorsData(String uid) => 'users/$uid/debts';
}

final appDatabaseProvider =
    Provider.autoDispose<AppDataBase>((ref) => AppDataBase());

class AppDataBase {
  AppDataBase();
  final FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<void> createDashBoard(AppUser user) async {
    final emptyDashboard = DashboardData(
      id: user.uid,
      balance: 0.0,
      email: user.email,
      fullName: user.fullName,
    );
    ref.doc(FirestorePath.dashboardData(user.uid)).set(emptyDashboard.toJson());
  }

  Stream<Map<String, dynamic>?> streamDashBoardData(AppUser user) async* {
    yield* ref
        .doc(FirestorePath.dashboardData(user.uid))
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  Future<bool> updateDashboard(AppUser user, DashboardData data) async {
    return await ref
        .doc(FirestorePath.dashboardData(user.uid))
        .update(data.toJson())
        .then((value) => true);
  }

  Future<bool> addTransaction(AppUser user, Activity activity) async {
    //add the transaction and update dashboard data
    final dashDocRef = ref.doc(FirestorePath.dashboardData(user.uid));
    final activityCollection =
        ref.collection(FirestorePath.transactionData(user.uid));
    return ref.runTransaction((transaction) async {
      final dash = await transaction.get(dashDocRef);

      final newBalCount = dash.get("balance") +
          (activity.type == ActivityType.credit
              ? activity.amount
              : -activity.amount);

      transaction.update(dashDocRef, {"balance": newBalCount});
      transaction.set(activityCollection.doc(), activity.toJson());
      return true;
    });
  }

  Stream<List<Map<String, dynamic>>?> streamTransactionData(
      AppUser user) async* {
    yield* ref
        .collection(FirestorePath.transactionData(user.uid))
        .snapshots()
        .map((snapshot) => snapshot.docs.map((item) => item.data()).toList());
  }

  Future<bool> addDebt(AppUser user, Debt debt) async {
    final collection = ref.collection(FirestorePath.debtorsData(user.uid));

    await collection.add(debt.toJson());

    await addTransaction(user, debt.toActivity());

    return true;
  }

  Stream<List<Map<String, dynamic>>?> streamDebtData(AppUser user) async* {
    yield* ref
        .collection(FirestorePath.debtorsData(user.uid))
        .snapshots()
        .map((snapshot) => snapshot.docs.map((item) => item.data()).toList());
  }

  // Future<bool> hasPaidDebt(AppUser user, Debt debt) async {
  //   final collection = ref.collection(FirestorePath.debtorsData(user.uid));

  //   collection.where("id",isEqualTo: debt.id,).
  // }
}
