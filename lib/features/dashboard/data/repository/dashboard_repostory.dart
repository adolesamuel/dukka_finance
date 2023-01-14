import 'package:dartz/dartz.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failures/failure.dart';

final dashboardRepoProvider =
    Provider<DashboardRepository>((ref) => DashboardRepositoryImpl(ref));

abstract class DashboardRepository {
  ///A dashboard is created for user on create account.
  Stream<Either<Failure, DashboardData>> streamDashBoardData(AppUser user);
}

//
class DashboardRepositoryImpl implements DashboardRepository {
  final AppDataBase database;

  DashboardRepositoryImpl(Ref ref) : database = ref.read(appDatabaseProvider);

  @override
  Stream<Either<Failure, DashboardData>> streamDashBoardData(
      AppUser user) async* {
    yield* database.streamDashBoardData(user).map((event) {
      if (event == null) {
        database.createDashBoard(user);
      }
      return Right<Failure, DashboardData>(DashboardData.fromJson(event!));
    }).handleError((error, stack) {
      return Left(CommonFailure('Error', error.toString()));
    });
  }
}
