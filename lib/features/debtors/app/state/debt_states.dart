part of 'debt_state_notifier.dart';

class DebtState {}

class DebtInitialState extends DebtState {}

class CreateDebtLoading extends DebtState {}

class CreateDebtFailure extends DebtState {
  final Failure failure;

  CreateDebtFailure(this.failure);
}

class CreateDebtSuccess extends DebtState {
  final bool status;

  CreateDebtSuccess(this.status);
}
