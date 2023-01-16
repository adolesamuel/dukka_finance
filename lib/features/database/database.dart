import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestorePath {
  static String dashboardData(String uid) => 'dashboard/$uid';
  static String transactionData(String uid) => 'users/$uid/transactions';
  static String debtorsData(String uid) => 'users/$uid/debts';
  static String debtData(String uid, String debtId) =>
      'users/$uid/debts/$debtId';
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

    await collection
        .add(debt.toJson())
        .then((value) => value.update({'id': value.id}));

    await addTransaction(user, debt.toActivity());

    return true;
  }

  Stream<List<Map<String, dynamic>>?> streamDebtData(AppUser user) async* {
    yield* ref
        .collection(FirestorePath.debtorsData(user.uid))
        .snapshots()
        .map((snapshot) => snapshot.docs.map((item) => item.data()).toList());
  }

  Future<bool> hasPaidDebt(AppUser user, Debt debt) async {
    final debtRef = ref.doc(FirestorePath.debtData(user.uid, debt.id));

    //Update debt is paid.
    debtRef.update({'is_paid': true});

    final paidDebt = debt.toActivity().copyWith(
          sender: debt.receiver,
          receiver: debt.sender,
          type: ActivityType.credit,
          date: DateTime.now(),
          description: 'Paid Debt for ${debt.description}',
        );

    //add entry as activity
    addTransaction(user, paidDebt);

    return true;
  }

  Future<bool> updateContactInfo(
    AppUser user,
    Debt debt, {
    String? email,
    String? phone,
  }) async {
    final debtRef = ref.doc(FirestorePath.debtData(user.uid, debt.id));

    if (email != null) {
      debtRef.update({'receiver_email': email});
    }
    if (phone != null) {
      debtRef.update({'receiver_phone_number': phone});
    }
    return true;
  }

  Future<bool> updateLastContactInfo(
    AppUser user,
    Debt debt,
  ) async {
    final debtRef = ref.doc(FirestorePath.debtData(user.uid, debt.id));

    final lastContactDate = DateTime.now().toIso8601String();

    debtRef.update({'last_contact_date': lastContactDate});
    return true;
  }

  Future<bool> deleteDebt(
    AppUser user,
    Debt debt,
  ) async {
    final debtRef = ref.doc(FirestorePath.debtData(user.uid, debt.id));

    debtRef.delete();
    return true;
  }

  Stream<Map<String, dynamic>?> streamDebtDetailData(
      AppUser user, Debt debt) async* {
    final debtRef = ref.doc(FirestorePath.debtData(user.uid, debt.id));

    yield* debtRef.snapshots().map((event) => event.data());
  }
}
