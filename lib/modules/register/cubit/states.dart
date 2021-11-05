abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterChangePasswordStateState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  String error;
  RegisterErrorState(this.error);
}

class RegisterCreateUserSuccessState extends RegisterStates {}

class RegisterCreateUserErrorState extends RegisterStates {
  String error;
  RegisterCreateUserErrorState(this.error);
}