import 'package:dukka_finance/features/auth/app/state/auth_state.dart';
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
}
