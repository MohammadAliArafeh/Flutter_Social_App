import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = ['Home', 'Chats', 'New Post', 'Users', 'Settings'];

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
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

  UserModel? userModel;

  void getUser() {
    emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error.toString()));
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? coverImage,
  }) {
    emit(HomeUpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      coverImage: coverImage ?? userModel!.coverImage,
      email: userModel!.email,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      print('update done');
      getUser();
    }).catchError((error) {
      emit(HomeUpdateUSerErrorState());
    });
  }

  File? profileImage;
  File? profileCoverImage;
  var picker = ImagePicker();

  void changeImageProfile() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      print('changeImageProfile' + profileImage!.path);
      emit(HomeProfileImagePickedSuccessState());
    } else {
      print('image does bot picked');
      emit(HomeProfileImagePickedErrorState());
    }
  }

  void changeCoverImageProfile() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profileCoverImage = File(pickedImage.path);
      print('changeCoverImageProfile' + profileCoverImage!.path);
      emit(HomeProfileCoverImagePickedSuccessState());
    } else {
      print('image does bot picked');
      emit(HomeProfileCoverImagePickedErrorState());
    }
  }

  void updateImageProfile({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(HomeUpdateProfileImageLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: val,
        );
        print('updateImageProfile' + val);
      }).catchError((error) {
        emit(HomeUpdateProfileImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUpdateProfileImageErrorState());
    });
  }

  void updateCoverImageProfile({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(HomeUpdateProfileCoverImageLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileCoverImage!.path).pathSegments.last}')
        .putFile(profileCoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((val) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          coverImage: val,
        );
        print('updateCoverImageProfile' + val);
      }).catchError((error) {
        emit(HomeUpdateProfileCoverImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUpdateProfileCoverImageErrorState());
    });
  }

  File? postImage;

  void getPostImage() async {
    XFile? pickImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickImage != null) {
      postImage = File(pickImage.path);
      emit(HomeGetPostImageSuccessState());
    } else {
      emit(HomeGetPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageSuccessState());
  }

  void uploadPostImage({
    required String dateTime,
    required String postText,
  }) {
    emit(HomeCreatePostLoadingState());

    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          postText: postText,
          postImage: value,
        );
      }).catchError((error) {
        emit(HomeCreatePostErrorState());
      });
    }).catchError((error) {
      emit(HomeCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String postText,
    String? postImage,
  }) {
    emit(HomeCreatePostLoadingState());
    PostModel postModel = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: dateTime,
        postText: postText,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(HomeCreatePostSuccessState());
    }).catchError((error) {
      emit(HomeCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];

  void getPosts() {
    emit(HomeGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostModel.fromJson(element.data()));
      });
      emit(HomeGetPostImageSuccessState());
    }).catchError((error) {
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getUsers() {
    emit(HomeGetAllUsersLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
      });
      emit(HomeGetAllUsersSuccessState());
    }).catchError((error) {
      emit(HomeGetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        senderId: userModel!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);

    // set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(HomeGetAllMessagesSuccessState());
    });
  }
}
