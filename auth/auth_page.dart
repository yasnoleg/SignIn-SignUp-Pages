import 'package:flutter/material.dart';

import '../firebase pages/signin.dart';
import '../firebase pages/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPg = true;

  void toogleScreens() {
    setState(() {
      showLoginPg = !showLoginPg;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPg) {
      return MyLoginPageUi(showRegisterPage: toogleScreens,);
    } else {
      return MySignUpPageUi(showLoginPage: toogleScreens,);
    }
}}