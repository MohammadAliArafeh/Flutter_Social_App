import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var profileImage = HomeCubit.get(context).profileImage;
        var profileCoverImage = HomeCubit.get(context).profileCoverImage;

        nameController.text = cubit.userModel!.name!;
        bioController.text = cubit.userModel!.bio!;
        phoneController.text = cubit.userModel!.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            TextButton(
                onPressed: () {
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: Text('Update')),
            SizedBox(
              width: 8,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is HomeUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is HomeUpdateUserLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 200,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4.0),
                                        topLeft: Radius.circular(4.0)),
                                    image: DecorationImage(
                                      image: profileCoverImage == null
                                          ? NetworkImage(
                                              '${cubit.userModel!.coverImage}')
                                          : FileImage(profileCoverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey[200],
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.changeCoverImageProfile();
                                        if (profileCoverImage != null) {
                                          cubit.updateCoverImageProfile(
                                              name: nameController.text,
                                              bio: bioController.text,
                                              phone: phoneController.text);
                                        }
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      ))),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${cubit.userModel!.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey[200],
                                child: IconButton(
                                    onPressed: () {
                                      cubit.changeImageProfile();

                                      if (profileImage != null) {
                                        cubit.updateImageProfile(
                                            name: nameController.text,
                                            bio: bioController.text,
                                            phone: phoneController.text);
                                      }
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (profileImage != null ||
                      profileCoverImage != null)
                    Row(
                      children: [
                        if (profileImage!= null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    cubit.updateImageProfile(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload profile',
                                ),
                                if (state is HomeUpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is HomeUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (profileCoverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    cubit.updateCoverImageProfile(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'upload cover',
                                ),
                                if (state is HomeUpdateUserLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is HomeUpdateUserLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (profileImage != null ||
                      profileCoverImage != null)
                    SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
