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

class DebtPaidLoading extends DebtState {}

class DebtPaidFailure extends DebtState {
  final Failure failure;

  DebtPaidFailure(this.failure);
}

class DebtPaidSuccess extends DebtState {
  final bool status;

  DebtPaidSuccess(this.status);
}

class DebtDetailLoading extends DebtState {}

class DebtDetailFailure extends DebtState {
  final Failure failure;

  DebtDetailFailure(this.failure);
}

class DebtDetailSuccess extends DebtState {
  final Debt? debt;

  DebtDetailSuccess(this.debt);
}

class UpdateContactInfoLoading extends DebtState {}

class UpdateContactInfoFailure extends DebtState {
  final Failure failure;

  UpdateContactInfoFailure(this.failure);
}

class UpdateContactInfoSuccess extends DebtState {
  final bool status;

  UpdateContactInfoSuccess(this.status);
}

class UpdateLastCallDateLoading extends DebtState {}

class UpdateLastCallDateFailure extends DebtState {
  final Failure failure;

  UpdateLastCallDateFailure(this.failure);
}

class UpdateLastCallDateSuccess extends DebtState {
  final bool status;

  UpdateLastCallDateSuccess(this.status);
}

class DeleteDebtLoading extends DebtState {}

class DeleteDebtFailure extends DebtState {
  final Failure failure;

  DeleteDebtFailure(this.failure);
}

class DeleteDebtSuccess extends DebtState {
  final bool status;

  DeleteDebtSuccess(this.status);
}
