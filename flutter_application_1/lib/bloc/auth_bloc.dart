import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase/auth.dart';
import 'package:flutter_application_1/bloc/auth_event.dart';
import 'package:flutter_application_1/bloc/auth_state.dart';
import 'package:flutter_application_1/firebase/exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    Firebase.initializeApp().then((value) => auth = Auth());
  }
  late Auth auth;
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield LoadingState();
    try {
      if (event is SignInEvent) {
        await auth.SignIn(event.email, event.password);
        yield AuthInitial(success: true);
      }
      if (event is SignUpEvent) {
        await auth.SingUp(event.email, event.password);
        yield AuthInitial(success: true);
      }
    } on AuthException catch (exception) {
      yield AuthInitial(error: true, errorText: exception.caption);
    }
  }
}
