import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';

class AuthState {}

class AuthStateInitial extends AuthState {}

class LogInLoadingState extends AuthState {}

class LogInFailureState extends AuthState {
  final Failure failure;

  LogInFailureState(this.failure);
}

class LogInSuccessState extends AuthState {
  final AppUser authCredential;

  LogInSuccessState(this.authCredential);
}

class CreatePasswordLoadingState extends AuthState {}

class CreatePasswordFailureState extends AuthState {
  final Failure failure;

  CreatePasswordFailureState(this.failure);
}

class CreatePasswordSuccessState extends AuthState {
  final AppUser status;

  CreatePasswordSuccessState(this.status);
}

class LogOutLoading extends AuthState {}

class LogOutDone extends AuthState {
  final bool status;

  LogOutDone(this.status);
}
