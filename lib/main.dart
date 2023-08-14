import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'config/app_color.dart';
import 'config/app_route.dart';
import 'config/session.dart';
import 'controllers/c_account.dart';
import 'controllers/c_explore.dart';
import 'controllers/c_feed.dart';
import 'controllers/c_home.dart';
import 'controllers/c_my_topic.dart';
import 'controllers/c_user.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CUser>(create: (_) => CUser()),
        ChangeNotifierProvider<CHome>(create: (_) => CHome()),
        ChangeNotifierProvider<CFeed>(create: (_) => CFeed()),
        ChangeNotifierProvider<CExplore>(create: (_) => CExplore()),
        ChangeNotifierProvider<CMyTopic>(create: (_) => CMyTopic()),
        ChangeNotifierProvider<CAccount>(create: (_) => CAccount()),
      ],
      builder: (context, child) {
        Session.getUser().then((user) {
          if (user != null) {
            context.read<CUser>().data = user;
          }
        });
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Discuss App',
          theme: ThemeData(
            primaryColor: AppColor.primary,
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColor.primary,
              secondary: AppColor.primary,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
            ),
            // useMaterial3: true,
          ),
          routerConfig: AppRoute.routeConfig,
        );
      },
    );
  }
}
