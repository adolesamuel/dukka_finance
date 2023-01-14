import 'package:dartz/dartz.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failures/failure.dart';

final dashboardRepoProvider =
    Provider<DashboardRepository>((ref) => DashboardRepositoryImpl());

abstract class DashboardRepository {
  Future<void> createDashBoard();
  Stream<Either<Failure, DashboardData>> streamDashBoardData();
}

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<void> createDashBoard() {
    // TODO: implement createDashBoard
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, DashboardData>> streamDashBoardData() {
    // TODO: implement streamDashBoardData
    throw UnimplementedError();
  }
}
