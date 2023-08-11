import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_route.dart';
import '../../controllers/c_my_topic.dart';
import '../../controllers/c_user.dart';
import '../../models/topic.dart';
import 'package:provider/provider.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  deleteTopic(BuildContext context, Topics topic) {}

  @override
  Widget build(BuildContext context) {
    final user = context.read<CUser>().data;
    context.read<CMyTopic>().setTopics(user!.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DView.textTitle('My Topic', size: 24),
        ),
        Expanded(
          child: Consumer<CMyTopic>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) return DView.empty();
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                itemCount: _.topics.length,
                itemBuilder: (context, index) {
                  Topics topics = _.topics[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${index + 1}'),
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      topics.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      topics.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'detail') {
                          context.push(AppRoute.detailTopic,
                              extra: topics..users = user);
                        }
                        if (value == 'update') {
                          context.push(AppRoute.updateTopic,
                              extra: topics..users = user);
                        }
                        if (value == 'delete') {
                          deleteTopic(context, topics);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'detail',
                          child: Text('Detail'),
                        ),
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('Update'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
