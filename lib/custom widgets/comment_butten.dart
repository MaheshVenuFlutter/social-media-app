import 'package:flutter/material.dart';

class CommentButten extends StatelessWidget {
  final void Function()? ontap;
  const CommentButten({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Icon(
        Icons.comment,
        color: Colors.grey,
      ),
    );
  }
}
