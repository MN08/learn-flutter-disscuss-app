import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/c_follower.dart';
import '../models/user.dart';
import '../widget/item_user.dart';

class FollowerPage extends StatelessWidget {
  const FollowerPage({super.key, required this.user});
  final Users user;

  @override
  Widget build(BuildContext context) {
    context.read<CFollower>().setFollower(user.id);
    return Scaffold(
      appBar: DView.appBarLeft("${user.username}'s follower"),
      body: Consumer<CFollower>(
        builder: (contextConsumer, _, child) {
          if (_.follower.isEmpty) return DView.empty();
          return ListView.builder(
            itemCount: _.follower.length,
            itemBuilder: (context, index) {
              return ItemUser(user: _.follower[index]);
            },
          );
        },
      ),
    );
  }
}
