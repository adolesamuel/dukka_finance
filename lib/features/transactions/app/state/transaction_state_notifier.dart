import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:dukka_finance/features/transactions/data/repository/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'transaction_states.dart';

final activityStateProvider =
    StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  return TransactionNotifier(ref);
});

class TransactionNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository _transactionRepository;
  TransactionNotifier(Ref ref)
      : _transactionRepository = ref.read(transactionRepositoryProvider),
        super(InitialTransactionState());

  Future<void> createTransaction(Activity trans) async {
    state = AddTransactionLoadingState();

    AppUser user = AppUserManager.user;

    final addTransOrError =
        await _transactionRepository.addTransaction(user, trans);

    state = addTransOrError.fold(
      (l) => AddTransactionFailure(l),
      (r) => AddTransactionSuccess(r),
    );
  }

  Stream<TransactionState> streamTransaction() async* {
    yield TransactionDataLoading();
    AppUser user = AppUserManager.user;

    yield* _transactionRepository.streamTransactionData(user).map((event) {
      return event.fold(
        (l) => TransactionFailure(l),
        (r) => TransactionData(r),
      );
    });
  }
}
