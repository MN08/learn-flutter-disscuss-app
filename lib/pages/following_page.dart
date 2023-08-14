import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/c_following.dart';
import '../models/user.dart';
import '../widget/item_user.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key, required this.user});
  final Users user;

  @override
  Widget build(BuildContext context) {
    context.read<CFollowing>().setFollowing(user.id);
    return Scaffold(
      appBar: DView.appBarLeft("${user.username} following..."),
      body: Consumer<CFollowing>(
        builder: (contextConsumer, _, child) {
          if (_.following.isEmpty) return DView.empty();
          return ListView.builder(
            itemCount: _.following.length,
            itemBuilder: (context, index) {
              return ItemUser(user: _.following[index]);
            },
          );
        },
      ),
    );
  }
}
