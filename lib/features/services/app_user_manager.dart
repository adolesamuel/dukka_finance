import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final userManagerProvider = Provider((ref) => AppUserManager.user);

class AppUserManager {
  static AppUser get user =>
      AppUser.fromFirebaseUser(FirebaseAuth.instance.currentUser!);
}
