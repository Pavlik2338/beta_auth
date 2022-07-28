import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  final bool error;
  final String errorText;
  final bool success;

  AuthInitial(
      {@required this.error = false,
      @required this.errorText = "",
      @required this.success = false});
}

class LoadingState extends AuthInitial {}
