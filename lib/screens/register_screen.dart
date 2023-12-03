import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // show error message
  void displayErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  //regester user
  void signUp() async {
    //show progres indicator
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //make sure passwordMatch

    if (passwordController.text != confirmPassword.text) {
      // pop progress indicator
      Navigator.pop(context);
      //show error meassage
      displayErrorMessage("Passwords don't match!");
      return;
    }
    //creating user
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // create a new document in the fire base cloude data base called Users
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'username': emailController.text.split('@')[0], // take the name befor @
        'bio': 'empty bio..' // initally empty
        // add more feilds in future
      });
      //pop loadig indicator

      Navigator.pop(context);
    } on FirebaseException catch (e) {
      //pop loadig indicator

      Navigator.pop(context);
      //show error to users

      displayErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                  controller: confirmPassword,
                  hint: 'confirm password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // butten
                Mybutten(
                    ontap: () {
                      signUp();
                    },
                    text: 'Sign up'),
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
