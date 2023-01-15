part of 'transaction_state_notifier.dart';

class TransactionState {}

class InitialTransactionState extends TransactionState {}

class AddTransactionLoadingState extends TransactionState {}

class AddTransactionFailure extends TransactionState {
  final Failure failure;

  AddTransactionFailure(this.failure);
}

class AddTransactionSuccess extends TransactionState {
  final bool status;

  AddTransactionSuccess(this.status);
}
