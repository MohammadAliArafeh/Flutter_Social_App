import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  ChatDetailsScreen(this.userModel);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        HomeCubit.get(context).getMessages(receiverId: userModel.uId!);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage('${userModel.image}'),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                HomeCubit.get(context).messages.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (HomeCubit.get(context)
                                    .messages[index]
                                    .receiverId ==
                                userModel.uId) {
                              return buildMyMessage(HomeCubit.get(context).messages[index]);
                            }
                            return buildMessage(HomeCubit.get(context).messages[index]);
                          },
                          itemCount: HomeCubit.get(context).messages.length,
                        ),
                      )
                    : Expanded(
                      child: const Center(
                          child: Text('Empty Conversation'),
                        ),
                    ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          color: defaultColor,
                          child: MaterialButton(
                            onPressed: () {
                              HomeCubit.get(context).sendMessage(
                                receiverId: userModel.uId!,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );
                            },
                            minWidth: 1.0,
                            child: const Icon(
                              IconBroken.Send,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Text('${model.text}'),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0)),
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          child: Text('${model.text}'),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          decoration: BoxDecoration(
            color: defaultColor!.withOpacity(.2),
            borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0)),
          ),
        ),
      );
}
