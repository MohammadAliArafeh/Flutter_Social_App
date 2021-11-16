import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return HomeCubit.get(context).users.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) =>
                    buildChatItem(HomeCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: HomeCubit.get(context).users.length)
            : HomeCubit.get(context).users.isEmpty ? const Center(child: Text('no chats'),) : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: (){
            navigateTo(context, ChatDetailsScreen(model));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      );
}
