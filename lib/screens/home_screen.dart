import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/text_feild.dart';
import 'package:social_media_app/custom%20widgets/wall_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  //user
  final currentUser = FirebaseAuth.instance.currentUser;

  //text controller
  final textController = TextEditingController();

  //post message
  void postMessage() {
    //only post if the text feild is not null

    if (textController.text.isNotEmpty) {
      // store to firebase
      FirebaseFirestore.instance.collection("User Posts").add(
        {
          'UserEmail': currentUser!.email,
          'Message': textController.text,
          'TimeStamp': Timestamp.now(),
        },
      );
    }

    setState(() {
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("dinagn"),
        actions: [
          //sign out
          IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Column(
        children: [
          //the wall

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy('TimeStamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      //get messages
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error...${snapshot.error.toString()}'),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          //post message
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: MyTestFeild(
                      controller: textController, hint: "whats on your mind.."),
                ),

                //post butten
                IconButton(
                    onPressed: () {
                      postMessage();
                    },
                    icon: const Icon(Icons.arrow_circle_up))
              ],
            ),
          ),

          //loged in as
          Text("loged in as ${currentUser!.email}"),

          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
