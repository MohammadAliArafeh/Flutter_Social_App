import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData passIcon = Icons.remove_red_eye_outlined;
  bool passState = true;

  void changePasswordState() {
    passState = !passState;
    passIcon = passState
        ? Icons.visibility_off_outlined
        : Icons.remove_red_eye_outlined;
    emit(LoginChangePasswordStateState());
  }
}
