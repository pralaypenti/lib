// lib/animated_login/bloc.dart

import 'package:bloc_stm/animated_login/event.dart';
import 'package:bloc_stm/animated_login/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginChecking());

      await Future.delayed(const Duration(seconds: 1));

      if (event.email == "admin@gmail.com" && event.password == "admin") {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    });

    on<LoginEmailFocused>((event, emit) => emit(LoginEmailTracking(0)));
    on<LoginPasswordFocused>((event, emit) => emit(LoginEyeCover()));
    on<LoginEmailChanged>((event, emit) => emit(LoginEmailTracking(event.email.length)));
  }
}
