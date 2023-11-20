import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/butten.dart';
import 'package:social_media_app/custom%20widgets/text_feild.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? ontap;
  const RegisterScreen({super.key, required this.ontap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
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
                  'Lets create an account for you',
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
                MyTestFeild(
                  controller: passwordController,
                  hint: 'confirm password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // butten
                Mybutten(ontap: () {}, text: 'Sign up'),
                //go to register page
                const SizedBox(
                  height: 24,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Allready have an account?',
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
                        'Login in now',
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
