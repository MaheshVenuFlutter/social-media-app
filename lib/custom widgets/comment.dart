import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment(
      {super.key, required this.text, required this.time, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment

          Text(text),
          // user  //time
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                user,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              Text(
                " . ",
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
