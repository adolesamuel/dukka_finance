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

class DebtListLoading extends DebtState {}

class DebtListFailure extends DebtState {
  final Failure failure;

  DebtListFailure(this.failure);
}

class DebtListSuccess extends DebtState {
  final List<Debt> listOfDebts;

  DebtListSuccess(this.listOfDebts);
}
