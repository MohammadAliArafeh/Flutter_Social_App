import 'package:social_app/models/user_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangePasswordStateState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  String error;
  RegisterErrorState(this.error);
}

class RegisterCreateUserSuccessState extends RegisterStates {
  final UserModel userModel;

  RegisterCreateUserSuccessState(this.userModel);
}

class RegisterCreateUserErrorState extends RegisterStates {
  String error;
  RegisterCreateUserErrorState(this.error);
}