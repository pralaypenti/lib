// lib/animated_login/state.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginChecking extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}

class LoginEyeCover extends LoginState {}

class LoginEmailTracking extends LoginState {
  final int caretPosition;
  LoginEmailTracking(this.caretPosition);
}
