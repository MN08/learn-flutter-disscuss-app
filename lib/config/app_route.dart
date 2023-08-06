import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter_discuss_app/controllers/c_add_topic.dart';
import 'package:learn_flutter_discuss_app/controllers/c_comment.dart';
import 'package:learn_flutter_discuss_app/controllers/c_follower.dart';
import 'package:learn_flutter_discuss_app/controllers/c_following.dart';
import 'package:learn_flutter_discuss_app/controllers/c_profile.dart';
import 'package:learn_flutter_discuss_app/controllers/c_search.dart';
import 'package:learn_flutter_discuss_app/pages/error_page.dart';
import 'package:learn_flutter_discuss_app/pages/register_page.dart';
import 'package:provider/provider.dart';
import '../config/session.dart';
import '../models/user.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

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
          if (state.name == login || state.name == register) {
            return null;
          }
          return login;
        }
        return null;
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
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: addTopic,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CAddTopic(),
            child: const Scaffold(),
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
