import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
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

  AuthRepository(Ref ref) : _firebaseAuth = ref.read(_firebaseAuthProvider);

  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      AuthSignIn data) async {
    return _firebaseAuth
        .createUserWithEmailAndPassword(
            email: data.email, password: data.password)
        .then((value) => Right<Failure, UserCredential>(value))
        .onError((error, stackTrace) {
      final failure = CommonFailure('SignUp Failure', error.toString());
      throw Left(failure);
    });
  }

  Future<Either<Failure, UserCredential>> signInUserWithEmailAndPassword(
      AuthSignIn data) {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: data.email, password: data.password)
        .then((value) => Right<Failure, UserCredential>(value))
        .onError((error, stackTrace) {
      final failure = CommonFailure('SignIn Failure', error.toString());
      throw Left(failure);
    });
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Stream<User?> authStream() async* {
    yield* _firebaseAuth.authStateChanges();
  }
}