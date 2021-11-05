import 'package:flutter/cupertino.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates {
  String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordStateState extends LoginStates {}
