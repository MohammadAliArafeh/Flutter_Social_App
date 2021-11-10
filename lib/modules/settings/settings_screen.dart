import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
        builder: (context,state){
        var cubit = HomeCubit.get(context);
        return Column(
          children: [
            Container(
              height: 200,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                topLeft: Radius.circular(4.0)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${cubit.userModel!.coverImage}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                          '${cubit.userModel!.image}'),
                    ),
                  )
                ],
              ),
            ),
            Text('${cubit.userModel!.name}'),
            Text('${cubit.userModel!.bio}',style: Theme.of(context).textTheme.caption,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(children: [
                      Text('34',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),),
                      Text('Posts',style: TextStyle(fontSize: 12),),
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(children: [
                      Text('101',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),),
                      const Text('Followers',style: TextStyle(fontSize: 12),),
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(children: [
                      Text('165',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),),
                      const Text('Following',style: TextStyle(fontSize: 12),),
                    ],),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Column(children: [
                      Text('10k',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 18),),
                      Text('Photos',style: TextStyle(fontSize: 12),),
                    ],),
                  ),
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Add Photos',style: TextStyle(fontSize: 12),))),
                SizedBox(width: 8,),
                OutlinedButton(onPressed: (){
                  navigateTo(context, EditProfileScreen());
                }, child: Icon(IconBroken.Edit,size: 18,))
              ],),
            )
          ],
        );
        },
    );
  }
}
