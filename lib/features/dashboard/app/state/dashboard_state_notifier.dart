import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/dashboard/data/repository/dashboard_repostory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'dashboard_state.dart';

final dashboardStateProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>(
  (ref) {
    return DashboardNotifier(ref);
  },
);

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository _dashboardRepository;
  DashboardNotifier(Ref ref)
      : _dashboardRepository = ref.read(dashboardRepoProvider),
        super(InitialDashboardState());

  Stream<DashboardState> streamDashboardState(AppUser user) async* {
    yield* _dashboardRepository.streamDashBoardData(user).map((event) {
      return state = event.fold(
        (l) => DashboardErrorState(l),
        (r) => DashboardDataState(r),
      );
    });
  }
}
