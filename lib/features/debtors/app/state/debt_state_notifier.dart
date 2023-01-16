import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/debtors/data/repository/repository.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'debt_states.dart';

final debtStateProvider =
    StateNotifierProvider<DebtNotifier, DebtState>((ref) => DebtNotifier(ref));

class DebtNotifier extends StateNotifier<DebtState> {
  final DebtorsRepository _debtorsRepository;

  DebtNotifier(Ref ref)
      : _debtorsRepository = ref.read(debtorsRepositoryProvider),
        super(DebtInitialState());

  Future<void> addDebt(Debt debt) async {
    state = CreateDebtLoading();

    final addDebtOrError =
        await _debtorsRepository.addItem(debt, AppUserManager.user);

    state = addDebtOrError.fold(
        (l) => CreateDebtFailure(l), (r) => CreateDebtSuccess(r));
  }

  Stream<DebtState> streamDebt() async* {
    yield DebtListLoading();
    AppUser user = AppUserManager.user;

    yield* _debtorsRepository.streamDebts(user).map((event) {
      return event.fold(
        (l) => DebtListFailure(l),
        (r) => DebtListSuccess(r),
      );
    });
  }

  Future<void> hasPaidDebt(Debt debt) async {
    state = DebtPaidLoading();

    final paidOrError =
        await _debtorsRepository.hasPaid(debt, AppUserManager.user);

    state = paidOrError.fold(
      (l) => DebtPaidFailure(l),
      (r) => DebtPaidSuccess(r),
    );
  }
}
