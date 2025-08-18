import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/google_login.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/header_login.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/login_alternative_container.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/login_button.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/login_form_container.dart';
import 'package:flutter_money_manager/src/features/login/ui/widgets/register_link.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 60, bottom: 20),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderLogin(),
                    SizedBox(height: 20),
                    LoginFormContainer(),
                    SizedBox(
                      height: 20,
                    ),
                    LoginButton(),
                    SizedBox(
                      height: 30,
                    ),
                    RegisterLink(),
                    SizedBox(height: 20),
                    LoginAlternativeContainer(),
                  ],
                ),
              ),
              Spacer(),
              GoogleLogin()
            ],
          ),
        ),
      ),
    );
  }
}
