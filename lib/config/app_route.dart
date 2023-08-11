import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/session.dart';
import '../controllers/c_add_topic.dart';
import '../controllers/c_comment.dart';
import '../controllers/c_follower.dart';
import '../controllers/c_following.dart';
import '../controllers/c_profile.dart';
import '../controllers/c_search.dart';
import '../models/user.dart';
import '../pages/add_topic.dart';
import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const addTopic = '/add-topic';
  static const profile = '/profile';
  static const search = '/search';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';

  static GoRouter routeConfig = GoRouter(
      errorBuilder: (context, state) => ErrorPage(
            title: 'Error Happen',
            description: state.error.toString(),
          ),
      debugLogDiagnostics: true,
      redirect: (context, state) async {
        Users? user = await Session.getUser();
        if (user == null) {
          if (state.uri.toString() == login ||
              state.uri.toString() == register) {
            return null;
          } else {
            return login;
          }
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: addTopic,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CAddTopic(),
            child: AddTopic(),
          ),
        ),
        GoRoute(
          path: profile,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CProfile(),
            child: const Scaffold(),
          ),
        ),
        GoRoute(
          path: search,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CSearch(),
            child: const Scaffold(),
          ),
        ),
        GoRoute(
          path: follower,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CFollower(),
            child: const Scaffold(),
          ),
        ),
        GoRoute(
          path: following,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CFollowing(),
            child: const Scaffold(),
          ),
        ),
        GoRoute(
          path: comment,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CComment(),
            child: const Scaffold(),
          ),
        ),
      ]);
}
