import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/custom%20widgets/comment.dart';
import 'package:social_media_app/custom%20widgets/comment_butten.dart';
import 'package:social_media_app/custom%20widgets/delete_butten.dart';
import 'package:social_media_app/custom%20widgets/like_butten.dart';
import 'package:social_media_app/healper/date_formater.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.likes,
      required this.postId,
      required this.time});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  //get the user details from firebase
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool showComment = false;

  // comment Text controller

  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleComment() {
    setState(() {
      showComment = !showComment;
    });
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

  // adding comment

  void addComment(String commentText) {
    // write the comment firestore  under comments for this user

    FirebaseFirestore.instance
        .collection("Users Post")
        .doc(widget.postId)
        .collection("Comments")
        .add(
      {
        "CommentText": commentText,
        "CommentedBy": currentUser.email,
        "CommentTime": Timestamp.now(),
        // formate later
      },
    );
  }

  // show a dialoug box for adding comment
  // neeed to fid a way to up date comment count

  void showCommentDialouge() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.outline,
          controller: _commentTextController,
          decoration: InputDecoration(
            hintText: "Your comment...",
          ),
        ),
        actions: [
          // cancel butten
          TextButton(
            onPressed: () {
              _commentTextController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // save butten
          TextButton(
            onPressed: () {
              // add thecomment
              addComment(_commentTextController.text);
              // clear the comment
              _commentTextController.clear();
              // pop the dialouge box

              Navigator.pop(context);
            },
            child: Text(
              "Post",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }

  void deletePost() {
    //show  a dialouge box asking for confirmatio befor deletig the post
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post"),
        actions: [
          // cancle
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          //detete
          TextButton(
            onPressed: () async {
              // delete the comments first
              final commentDoc = await FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .get();
              for (var doc in commentDoc.docs) {
                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .doc(doc.id)
                    .delete();
              }
              // delete the post
              FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .delete()
                  .then((value) {
                print(" post deleted");
                //todo;
                // add a task bar showing the sucess message in future
              }).catchError((error) {
                //todo;
                // add a task bar showing error message
                print("error = $error");
              });
              Navigator.pop(context);
            },
            child: const Text("delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //message and email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.message),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // user should be able to delete only his posts
                    if (widget.user == currentUser.email)
                      DeleteButten(ontap: deletePost),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
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

                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                // comment butten and comment count
                Column(
                  children: [
                    CommentButten(ontap: toggleComment
                        // showCommentDialouge
                        ),

                    const SizedBox(
                      height: 5,
                    ),

                    //like count

                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Users Post")
                            .doc(widget.postId)
                            .collection("Comments")
                            .orderBy("CommentTime", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          // show the loading cirecle if there is no data
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // Get the list of documents
                          List<QueryDocumentSnapshot> comments =
                              snapshot.data!.docs;

                          // Get the length of the list
                          int? commentsLength = comments.length;

                          return Text(
                            commentsLength.toString() ?? "0",
                            style: const TextStyle(color: Colors.grey),
                          );
                        }),

                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // display the comments

            Visibility(
              visible: showComment,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users Post")
                    .doc(widget.postId)
                    .collection("Comments")
                    .orderBy("CommentTime", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  // show the loading cirecle if there is no data
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map(
                          (doc) {
                            // get the coments

                            final commentData =
                                doc.data() as Map<String, dynamic>;
                            // geting comment length

                            // Get the list of documents
                            List<QueryDocumentSnapshot> comments =
                                snapshot.data!.docs;

                            // Get the length of the list
                            int commentsLength = comments.length;
                            // return the comment
                            return Comment(
                              text: commentData["CommentText"],
                              time: fromateDateTime(commentData["CommentTime"]),
                              user: commentData["CommentedBy"],
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          showCommentDialouge();
                        },
                        child: const Row(
                          children: [
                            Text("add a comment..."),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.comment,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
