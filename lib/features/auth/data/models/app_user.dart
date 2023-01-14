import 'package:firebase_auth/firebase_auth.dart';

//useful class to reduce tight coupling with firebase.

class AppUser {
  final String email;
  final String uid;
  final String? fullName;

  AppUser(this.email, this.uid, {this.fullName});

  factory AppUser.fromFirebaseUser(User user, {String? fullName}) {
    return AppUser(
      user.email ?? '',
      user.uid,
      fullName: fullName,
    );
  }
}
