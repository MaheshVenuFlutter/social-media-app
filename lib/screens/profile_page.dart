import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //get user details

  final currentUser = FirebaseAuth.instance.currentUser!;

  // get all the users

  final usersCollections = FirebaseFirestore.instance.collection("Users");

  // deit feilds

  Future<void> editFeilds(String feild) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Edit $feild",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter new $feild",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel butten
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // save butten

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newValue);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );

    // up date the firestore

    if (newValue.trim().length > 0) {
      // only up date if the feild is not null
      await usersCollections.doc(currentUser.email).update({feild: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // get the user data and display it
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                // profile picture
                const Icon(
                  Icons.person,
                  size: 72,
                ),

                const SizedBox(
                  height: 10,
                ),
                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                //user details
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "My deatils",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                //user name
                MyTextBox(
                  selectionName: 'userName',
                  text: userData['username'],
                  onPressed: () => editFeilds('username'),
                ),
                //bio
                MyTextBox(
                  selectionName: 'empty bio',
                  text: userData['bio'],
                  onPressed: () => editFeilds('bio'),
                ),

                // user posts
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Posts',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
