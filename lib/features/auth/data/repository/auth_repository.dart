import 'package:dartz/dartz.dart';
import 'package:dukka_finance/core/failures/failure.dart';
import 'package:dukka_finance/core/network_info/network_info.dart';
import 'package:dukka_finance/core/runner/service.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/auth/data/models/auth_signin.dart';
import 'package:dukka_finance/features/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<AppUser?>(
    (ref) => ref.watch(_firebaseAuthProvider).authStateChanges().map((event) {
          if (event == null) return null;
          return AppUser.fromFirebaseUser(event);
        }));

final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref),
);

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final NetworkInfo _networkInfo;

  AuthRepository(Ref ref)
      : _firebaseAuth = ref.read(_firebaseAuthProvider),
        _networkInfo = ref.read(networkInfoProvider);

  Future<Either<Failure, AppUser>> createUserWithEmailAndPassword(
      AuthSignUp data) async {
    ServiceRunner<Failure, AppUser> sR = ServiceRunner(_networkInfo);
    AppDataBase database = AppDataBase.instance;

    //after a user creates account their full name is created for them.

    return sR.tryRemoteandCatch(
        call: _firebaseAuth
            .createUserWithEmailAndPassword(
                email: data.email, password: data.password)
            .then((value) =>
                AppUser.fromFirebaseUser(value.user!, fullName: data.fullName))
            .then((value) async {
          print(value.email + value.uid);
          await database.createUserData(value.fullName ?? '', value.uid);
          return value;
        }),
        errorTitle: 'SignUp Failure');
  }

  Future<Either<Failure, AppUser>> signInUserWithEmailAndPassword(
      AuthSignIn data) async {
    ServiceRunner<Failure, AppUser> sR = ServiceRunner(_networkInfo);

    return sR.tryRemoteandCatch(
        call: _firebaseAuth
            .signInWithEmailAndPassword(
                email: data.email, password: data.password)
            .then((value) => AppUser.fromFirebaseUser(value.user!)),
        errorTitle: 'SignIn Failure');
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Stream<AppUser?> authStream() async* {
    yield* _firebaseAuth.authStateChanges().map((event) {
      if (event == null) {
        return null;
      }
      return AppUser.fromFirebaseUser(event);
    });
  }
}
