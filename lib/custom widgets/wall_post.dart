import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/like_butten.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.likes,
      required this.postId});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  //get the user details from firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggle like

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access the documents from firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);
    if (isLiked) {
      //if the post is like , add the user's email to the 'like feild
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email]),
      });
      //if the post is now unliked , remove the user's email from the "likes feilds"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            // //profile pic
            // Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.grey[400],
            //   ),
            //   padding: EdgeInsets.all(10),
            //   child: const Icon(
            //     Icons.person,
            //     color: Colors.white,
            //   ),
            // ),
// this collum contain the like butten
            Column(
              children: [
                //like butten
                LikeButten(
                    isLiked: isLiked,
                    onTap: () {
                      toggleLike();
                    }),

                const SizedBox(
                  height: 5,
                ),

                //like count
                Text(
                  widget.likes.length.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(
              width: 10,
            ),
            //message and email
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.message)
              ],
            )
          ],
        ),
      ),
    );
  }
}
