import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/features/auth/data/models/auth_signin.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// 2
final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider<FirestoreDatabase?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  // we only have a valid DB if the user is signed in
  if (auth.value?.uid != null) {
    return FirestoreDatabase(uid: auth.value!.uid);
  }
  // else we return null
  return null;
});

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      AuthSignIn data);
  Future<Either<Failure, UserCredential>> signInUserWithEmailAndPassword(
      AuthSignIn data);
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(Ref ref) : _firebaseAuth = ref.read(firebaseAuthProvider);

  @override
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

  @override
  signInUserWithEmailAndPassword(AuthSignIn data) {
    return _firebaseAuth
        .signInWithEmailAndPassword(email: data.email, password: data.password)
        .then((value) => Right<Failure, UserCredential>(value))
        .onError((error, stackTrace) {
      final failure = CommonFailure('SignIn Failure', error.toString());
      throw Left(failure);
    });
  }
}
