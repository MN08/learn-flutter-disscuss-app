import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:learn_flutter_discuss_app/config/app_color.dart';

Future<void> main() async {
  await initializeDateFormatting('id_ID');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.primary,
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(),
    );
  }
}
