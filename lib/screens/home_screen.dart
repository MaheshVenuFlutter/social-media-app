import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/drawer.dart';
import 'package:social_media_app/custom%20widgets/text_feild.dart';
import 'package:social_media_app/custom%20widgets/wall_post.dart';
import 'package:social_media_app/healper/date_formater.dart';
import 'package:social_media_app/screens/profile_page.dart';

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
          'Likes': [],
        },
      );
    }

    setState(() {
      textController.clear();
    });
  }

  void goToProfilePage() {
    // pop the menu drawer
    Navigator.pop(context);

    // go to profile screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(
        signOut: signOut,
        profileTap: goToProfilePage,
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("dinagn"),
      ),
      body: Column(
        children: [
          //the wall

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy('TimeStamp', descending: true)
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
                        postId: post.id,
                        time: fromateDateTime(
                          post['TimeStamp'],
                        ),
                        likes: List<String>.from(post['Likes'] ?? []),
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
