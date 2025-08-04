// lib/animated_login/event.dart

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

class LoginEmailFocused extends LoginEvent {}

class LoginPasswordFocused extends LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;
  LoginEmailChanged(this.email);
}
