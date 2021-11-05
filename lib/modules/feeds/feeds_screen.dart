import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 4,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Communicate With your friends',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 6,
                    ),
                itemCount: 10)
          ],
        ),
      ),
    );
  }

  Widget buildPostItem(context) => Card(
        elevation: 4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Mohammad Ali Arafeh',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            )
                          ],
                        ),
                        Text(
                          'January 12, 2021 04:00 pm',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.only(left: 4, top: 6, bottom: 6),
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        ),
                        minWidth: 1.0,
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: 25,
                      child: MaterialButton(
                        padding: EdgeInsets.only(left: 4, top: 6, bottom: 6),
                        child: Text(
                          '#flutter',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        ),
                        minWidth: 1.0,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit: BoxFit.cover,
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Likes',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/horizontal-shot-pretty-curly-haired-afro-american-woman-looks-positively-aside-has-tender-smile-wears-casual-anorak-looks-away-joyfully-being-good-mood-isolated-pink-wall_273609-42424.jpg',
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'write a comment ...',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
