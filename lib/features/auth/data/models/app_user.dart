import 'package:firebase_auth/firebase_auth.dart';

//useful class to reduce tight coupling with firebase.

class AppUser {
  final String email;
  final String uid;

  AppUser(this.email, this.uid);

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(user.email ?? '', user.uid);
  }
}
