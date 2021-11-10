import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              TextButton(
                  onPressed: () {
                    if (cubit.postImage != null) {
                      cubit.uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          postText: postTextController.text);
                    } else {
                      cubit.createPost(
                          dateTime: DateTime.now().toString(),
                          postText: postTextController.text);
                    }
                    pushAndFinish(context,FeedsScreen());
                  },
                  child: Text('Post'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (state is HomeCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                if (state is HomeCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is HomeCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-pretty-curly-haired-afro-american-woman-looks-positively-aside-has-tender-smile-wears-casual-anorak-looks-away-joyfully-being-good-mood-isolated-pink-wall_273609-42424.jpg'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        'Mohammad Ali Arafeh',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: InputDecoration(
                        hintText: 'What is in your mind ...',
                        border: InputBorder.none),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover,
                            )),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {
                          cubit.removePostImage();
                        },
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: Text('# Tags'))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
