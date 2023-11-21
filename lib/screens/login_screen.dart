import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/butten.dart';
import 'package:social_media_app/custom%20widgets/text_feild.dart';

class LoginScreen extends StatefulWidget {
  dynamic Function()? ontap;
  LoginScreen({super.key, required this.ontap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    try {
      print("hello called");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseException catch (e) {
      print("hello ${e.toString()}");
      if (e.code == 'user-not-found') {
        print("hello dingan");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo

                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                //welcome backessage
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "welcome back you've been missed",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //signin feild
                MyTestFeild(
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 24,
                ),
                //password feild
                MyTestFeild(
                  controller: passwordController,
                  hint: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // butten
                Mybutten(
                    ontap: () {
                      print("hello tapped");
                      signIn();
                    },
                    text: 'Sign in'),
                //go to register page
                const SizedBox(
                  height: 24,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
