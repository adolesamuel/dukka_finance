import 'package:dukka_finance/features/auth/app/state/auth_state.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/auth/data/models/auth_signin.dart';
import 'package:dukka_finance/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider =
    StateNotifierProvider.autoDispose(((ref) => AuthStateNotifier(ref)));

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  AuthStateNotifier(Ref ref)
      : _authRepository = ref.read(authRepoProvider),
        super(AuthStateInitial());

  Stream<AppUser?> authStateChanges() => _authRepository.authStream();

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
      {required String email,
      required String password,
      String? fullName}) async {
    state = CreatePasswordLoadingState();

    final AuthSignUp loginItem = AuthSignUp(email, password, fullName ?? '');

    final createPasswordOrError =
        await _authRepository.createUserWithEmailAndPassword(loginItem);

    state = createPasswordOrError.fold(
      (l) => CreatePasswordFailureState(l),
      (r) => CreatePasswordSuccessState(r),
    );
  }

  Future<void> signOut() async {
    state = LogOutLoading();
    await _authRepository.signOut();

    state = LogOutDone(true);
  }
}
