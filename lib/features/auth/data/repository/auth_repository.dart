import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/core/network_info/network_info.dart';
import 'package:dukka_finance/core/runner/service.dart';
import 'package:dukka_finance/features/auth/data/models/auth_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(_firebaseAuthProvider).authStateChanges());

final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref),
);

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final NetworkInfo _networkInfo;

  AuthRepository(Ref ref)
      : _firebaseAuth = ref.read(_firebaseAuthProvider),
        _networkInfo = ref.read(networkInfoProvider);

  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      AuthSignIn data) async {
    ServiceRunner<Failure, UserCredential> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _firebaseAuth.createUserWithEmailAndPassword(
            email: data.email, password: data.password),
        errorTitle: 'SignUp Failure');
  }

  Future<Either<Failure, UserCredential>> signInUserWithEmailAndPassword(
      AuthSignIn data) async {
    ServiceRunner<Failure, UserCredential> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _firebaseAuth.signInWithEmailAndPassword(
            email: data.email, password: data.password),
        errorTitle: 'SignIn Failure');
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Stream<User?> authStream() async* {
    yield* _firebaseAuth.authStateChanges();
  }
}
