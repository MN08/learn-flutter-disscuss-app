import 'package:go_router/go_router.dart';
import 'package:learn_flutter_discuss_app/pages/error_page.dart';
import 'package:learn_flutter_discuss_app/pages/register_page.dart';
import '../config/session.dart';
import '../models/user.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

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
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => const RegisterPage(),
        ),
      ]);
}
