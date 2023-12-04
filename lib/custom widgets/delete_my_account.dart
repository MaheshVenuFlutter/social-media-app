import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/auth.dart';
import 'package:social_media_app/custom%20widgets/text_feild.dart';

class DeleteMyAccount extends StatelessWidget {
  DeleteMyAccount({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

// ...

  Future<void> deleteUser(BuildContext context) async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the email and password match
    if (currentUser != null &&
        currentUser.email == emailTextController.text &&
        passwordTextController.text.isNotEmpty) {
      // Sign in with the user's credentials to verify the password
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: currentUser.email!,
          password: passwordTextController.text,
        );

        // Delete user posts from "User Posts" collection
        await FirebaseFirestore.instance
            .collection("User Posts")
            .where('UserEmail', isEqualTo: currentUser.email)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Delete user information from "Users" collection
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .delete();

        // If sign-in is successful and posts are deleted, proceed with account deletion
        await currentUser.delete().then((value) {
          print("User deleted successfully");

          // Navigate to AuthScreen after successful deletion
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => AuthScreen(),
            ),
          );
        }).catchError((error) {
          print("Error deleting user: $error");
          // TODO: Show error message
        });

        // Sign out the user after deletion
        await FirebaseAuth.instance.signOut();
      } catch (error) {
        print("Error signing in: $error");
        // TODO: Show error message for incorrect password
      }
    } else {
      // TODO: Show error message for mismatched email and password
      print("Email and password do not match");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            MyTestFeild(controller: emailTextController, hint: "enter email"),
            const SizedBox(
              height: 20,
            ),
            MyTestFeild(
                controller: passwordTextController, hint: "enter password"),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).colorScheme.primary,
              child: TextButton(
                onPressed: () {
                  deleteUser(context);
                },
                child: const Text(
                  "delete Account",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
