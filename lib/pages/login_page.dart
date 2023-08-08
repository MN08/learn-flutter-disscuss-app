import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_route.dart';
import '../config/session.dart';
import '../controllers/c_user.dart';
import '../models/user.dart';
import '../sources/user_source.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text)
        .then((responseBody) {
      if (responseBody['success']) {
        var mapUser = Map<String, dynamic>.from(responseBody['data']);
        Users user = Users.fromJson(mapUser);
        Session.setUser(user);
        context.read<CUser>().data = user;

        DInfo.dialogSuccess(context, 'Login Success');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.go(AppRoute.home);
        });
      } else {
        DInfo.snackBarError(context, 'login failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade400,
              Colors.yellow.shade800,
            ],
          ),
        ),
        child: LayoutBuilder(builder: (context, constrains) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constrains.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DView.textTitle('Login'),
                          DView.spaceHeight(8),
                          const Divider(),
                          DView.spaceHeight(8),
                          DInput(
                            controller: controllerUsername,
                            title: 'Username',
                            spaceTitle: 5,
                          ),
                          DView.spaceHeight(),
                          DInputPassword(
                            controller: controllerPassword,
                            title: 'Password',
                            spaceTitle: 5,
                          ),
                          DView.spaceHeight(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => login(context),
                              child: const Text('Login'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun ?',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoute.register);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
