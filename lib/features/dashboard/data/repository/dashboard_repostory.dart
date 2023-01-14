import 'package:dartz/dartz.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failures/failure.dart';

final dashboardRepoProvider =
    Provider<DashboardRepository>((ref) => DashboardRepositoryImpl());

abstract class DashboardRepository {
  ///A dashboard is created for user on create account.
  Future<void> createDashBoard(AppUser user);
  Stream<Either<Failure, DashboardData>> streamDashBoardData();
}

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<void> createDashBoard(AppUser firebaseUser) {
    // TODO: implement createDashBoard
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, DashboardData>> streamDashBoardData() {
    // TODO: implement streamDashBoardData
    throw UnimplementedError();
  }
}
