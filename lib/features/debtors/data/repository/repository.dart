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
  Stream<Either<Failure, List<Debt>>> streamDebts(AppUser user);
  Stream<Either<Failure, Debt?>> streamDebtDetail(AppUser user, Debt debt);
  Future<Either<Failure, bool>> hasPaid(Debt debt, AppUser user);

  Future<Either<Failure, bool>> updateContactInfo(Debt debt, AppUser user,
      {String? email, String? phone});
  Future<Either<Failure, bool>> updateLastCallDate(Debt debt, AppUser user);
  Future<Either<Failure, bool>> deleteDebt(Debt debt, AppUser user);
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

  @override
  Stream<Either<Failure, List<Debt>>> streamDebts(AppUser user) async* {
    yield* dataBase.streamDebtData(user).map((event) {
      if (event == null) {
        //Empty list
        return const Right<Failure, List<Debt>>(<Debt>[]);
      }
      return Right<Failure, List<Debt>>(
          event.map((e) => Debt.fromJson(e)).toList());
    }).handleError((error, stack) {
      return Left(CommonFailure('Error', error.toString()));
    });
  }

  @override
  Future<Either<Failure, bool>> hasPaid(Debt debt, AppUser user) async {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);

    return sR.tryRemoteandCatch(
        call: dataBase.hasPaidDebt(user, debt), errorTitle: 'Error');
  }

  @override
  Future<Either<Failure, bool>> deleteDebt(Debt debt, AppUser user) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);
    return sR.tryRemoteandCatch(
        call: dataBase.deleteDebt(user, debt), errorTitle: 'Error');
  }

  @override
  Stream<Either<Failure, Debt?>> streamDebtDetail(
      AppUser user, Debt debt) async* {
    yield* dataBase.streamDebtDetailData(user, debt).map((event) {
      if (event == null) {
        return const Right<Failure, Debt?>(null);
      }
      return Right<Failure, Debt>(Debt.fromJson(event));
    }).handleError((error, stack) {
      return Left(CommonFailure('Error', error.toString()));
    });
  }

  @override
  Future<Either<Failure, bool>> updateContactInfo(Debt debt, AppUser user,
      {String? email, String? phone}) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);
    return sR.tryRemoteandCatch(
        call:
            dataBase.updateContactInfo(user, debt, email: email, phone: phone),
        errorTitle: 'Error');
  }

  @override
  Future<Either<Failure, bool>> updateLastCallDate(Debt debt, AppUser user) {
    ServiceRunner<Failure, bool> sR = ServiceRunner(networkInfo);
    return sR.tryRemoteandCatch(
        call: dataBase.updateLastContactInfo(user, debt), errorTitle: 'Error');
  }
}
