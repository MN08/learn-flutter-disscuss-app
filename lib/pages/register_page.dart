import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../sources/user_source.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  register(BuildContext context) {
    UserSource.register(controllerUsername.text, controllerPassword.text)
        .then((responseBody) {
      if (responseBody['success']) {
        DInfo.dialogSuccess(context, 'Register Success');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.pop();
        });
      } else {
        if (responseBody['message'] == 'username') {
          DInfo.snackBarError(context, 'username already registers');
        } else {
          DInfo.snackBarError(context, 'register failed');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade400,
              Colors.yellow.shade800,
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
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
                            DView.textTitle('Register'),
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
                                onPressed: () => register(context),
                                child: const Text('Register'),
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
                            'Sudah punya akun ?',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 48,
                            child: TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'login',
                                style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
