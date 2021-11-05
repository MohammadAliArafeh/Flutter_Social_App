import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        email: email,
        uId: value.user!.uid,
        name: name,
        phone: phone,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser(
      {required String email,
      required String uId,
      required String name,
      required String phone}) {
    UserModel userModel =
        UserModel(email: email, name: name, phone: phone, uId: uId,isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  IconData passIcon = Icons.remove_red_eye_outlined;
  bool passState = true;

  void changePasswordState() {
    passState = !passState;
    passIcon = passState
        ? Icons.visibility_off_outlined
        : Icons.remove_red_eye_outlined;
    emit(RegisterChangePasswordStateState());
  }
}
