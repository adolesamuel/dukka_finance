import 'package:dukka_finance/features/auth/app/state/auth_state.dart';
import 'package:dukka_finance/features/auth/data/models/auth_signin.dart';
import 'package:dukka_finance/features/auth/data/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider =
    StateNotifierProvider(((ref) => AuthStateNotifier(ref)));

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepoProvider),
        super(AuthStateInitial());

  Stream<User?> authStateChanges() => _authRepository.authStream();

  Future<void> login({required String email, required String password}) async {
    state = LogInLoadingState();

    final AuthSignIn loginItem = AuthSignIn(email, password);

    final logInOrError =
        await _authRepository.signInUserWithEmailAndPassword(loginItem);

    state = logInOrError.fold(
      (l) => LogInFailureState(l),
      (r) => LogInSuccessState(r),
    );
  }

  Future<void> createPassword(
      {required String email, required String password}) async {
    state = CreatePasswordLoadingState();

    final AuthSignIn loginItem = AuthSignIn(email, password);

    final createPasswordOrError =
        await _authRepository.createUserWithEmailAndPassword(loginItem);

    state = createPasswordOrError.fold(
      (l) => CreatePasswordFailureState(l),
      (r) => CreatePasswordSuccessState(r),
    );
  }
}
