import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/core/network_info/network_info.dart';
import 'package:dukka_finance/core/runner/service.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(ref);
});

abstract class TransactionRepository {
  Future<Either<Failure, bool>> addTransaction(
    AppUser user,
    Activity transaction,
  );

  Stream<Either<Failure, List<Activity>>> streamTransactionData(AppUser user);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final AppDataBase dataBase;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl(Ref ref)
      : networkInfo = ref.read(networkInfoProvider),
        dataBase = ref.read(appDatabaseProvider);

  @override
  Future<Either<Failure, bool>> addTransaction(
      AppUser user, Activity transaction) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);

    return sR.tryRemoteandCatch(
      call: dataBase.addTransaction(user, transaction),
      errorTitle: 'Error',
    );
  }

  @override
  Stream<Either<Failure, List<Activity>>> streamTransactionData(
      AppUser user) async* {
    yield* dataBase.streamTransactionData(user).map((event) {
      if (event == null) {
        //Empty list
        return const Right<Failure, List<Activity>>(<Activity>[]);
      }
      return Right<Failure, List<Activity>>(
          event.map((e) => Activity.fromJson(e)).toList());
    }).handleError((error, stack) {
      return Left(CommonFailure('Error', error.toString()));
    });
  }
}
