import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_route.dart';
import '../../config/session.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Session.clearUser();
              context.go(AppRoute.login);
            },
            child: const Text('Logout')),
      ),
    );
  }
}