import 'package:flutter/material.dart';
import 'package:social_media_app/screens/login_screen.dart';
import 'package:social_media_app/screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially , show the login screen

  bool showLoginScreen = true;

  //toggel between  login and register screen
  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(ontap: toggleScreen);
    } else {
      return RegisterScreen(ontap: toggleScreen);
    }
  }
}
