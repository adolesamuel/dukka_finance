import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/core/network_info/network_info.dart';
import 'package:dukka_finance/core/runner/service.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final debtorsRepositoryProvider =
    Provider<DebtorsRepository>((ref) => DebtorsRepositoryImpl(ref));

abstract class DebtorsRepository {
  Future<Either<Failure, bool>> addItem(Debt t, AppUser user);
}

class DebtorsRepositoryImpl implements DebtorsRepository {
  final AppDataBase dataBase;
  final NetworkInfo networkInfo;
  DebtorsRepositoryImpl(Ref ref)
      : networkInfo = ref.read(networkInfoProvider),
        dataBase = ref.read(appDatabaseProvider);

  @override
  Future<Either<Failure, bool>> addItem(Debt t, AppUser user) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);

    return sR.tryRemoteandCatch(
        call: dataBase.addDebt(user, t), errorTitle: 'Error');
  }

  // @override
  // Future<Either<Failure, bool>> deleteItem(Debt t) {
  //   return ref
  //       .doc(t.id)
  //       .delete()
  //       .then((value) => const Right<Failure, bool>(true))
  //       .catchError((error, stack) =>
  //           throw Left(CommonFailure('Delete Error', error.toString())));
  // }

  // @override
  // Stream<Either<Failure, List<Debt>>> getStream() async* {
  //   final data = ref.snapshots();
  //   yield* data.map((snapshot) {
  //     final result = snapshot.docs.map((e) => Debt.fromJson(e.data())).toList();

  //     return Right<Failure, List<Debt>>(result);
  //   }).handleError((error, stack) =>
  //       throw Left(CommonFailure('Error Stream', error.toString())));
  // }

  // @override
  // Future<Either<Failure, bool>> updateItem(Debt t) {
  //   // TODO: implement updateItem
  //   throw UnimplementedError();
  // }
}
