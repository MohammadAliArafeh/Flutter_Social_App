abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeChangeBottomNavBarIndex extends HomeStates{}

class HomeAddNewPost extends HomeStates{}
// get user
class HomeGetUserLoadingState extends HomeStates{}
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  final String error;

  HomeGetUserErrorState(this.error);
}
// pick image
class HomeProfileImagePickedSuccessState extends HomeStates{}
class HomeProfileImagePickedErrorState extends HomeStates{}
class HomeProfileImagePickedLoadingState extends HomeStates{}
//pick cover image
class HomeProfileCoverImagePickedSuccessState extends HomeStates{}
class HomeProfileCoverImagePickedErrorState extends HomeStates{}
class HomeProfileCoverImagePickedLoadingState extends HomeStates{}
// update image
class HomeUpdateProfileCoverImageSuccessState extends HomeStates{}
class HomeUpdateProfileCoverImageErrorState extends HomeStates{}
class HomeUpdateProfileCoverImageLoadingState extends HomeStates{}
// update cover image
class HomeUpdateProfileImageSuccessState extends HomeStates{}
class HomeUpdateProfileImageErrorState extends HomeStates{}
class HomeUpdateProfileImageLoadingState extends HomeStates{}
// update user
class HomeUpdateUserSuccessState extends HomeStates{}
class HomeUpdateUSerErrorState extends HomeStates{}
class HomeUpdateUserLoadingState extends HomeStates{}
// get post image
class HomeGetPostImageSuccessState extends HomeStates{}
class HomeGetPostImageErrorState extends HomeStates{}
// remove post image
class HomeRemovePostImageSuccessState extends HomeStates{}
// create post
class HomeCreatePostSuccessState extends HomeStates{}
class HomeCreatePostErrorState extends HomeStates{}
class HomeCreatePostLoadingState extends HomeStates{}
// get posts
class HomeGetPostsLoadingState extends HomeStates{}
class HomeGetPostsSuccessState extends HomeStates{}
class HomeGetPostsErrorState extends HomeStates{
  final String error;

  HomeGetPostsErrorState(this.error);
}