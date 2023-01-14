class AuthSignIn {
  final String email;
  final String password;

  AuthSignIn(this.email, this.password);
}

class AuthSignUp {
  final String email;
  final String password;
  final String fullName;

  AuthSignUp(this.email, this.password, this.fullName);
}
