import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUser() {
    emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<String> titles = ['Home', 'Chats', 'Users', 'Settings'];

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  void changeBottomNavBarIndex(int index) {
    if (index == 2) {
      emit(HomeAddNewPost());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavBarIndex());
    }
  }
}
