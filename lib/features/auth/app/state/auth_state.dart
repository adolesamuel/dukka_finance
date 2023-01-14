import 'package:dukka_finance/core/failures/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {}

class AuthStateInitial extends AuthState {}

class LogInLoadingState extends AuthState {}

class LogInFailureState extends AuthState {
  final Failure failure;

  LogInFailureState(this.failure);
}

class LogInSuccessState extends AuthState {
  final UserCredential authCredential;

  LogInSuccessState(this.authCredential);
}

class CreatePasswordLoadingState extends AuthState {}

class CreatePasswordFailureState extends AuthState {
  final Failure failure;

  CreatePasswordFailureState(this.failure);
}

class CreatePasswordSuccessState extends AuthState {
  final UserCredential status;

  CreatePasswordSuccessState(this.status);
}
