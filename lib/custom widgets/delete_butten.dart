import 'package:flutter/material.dart';

class DeleteButten extends StatelessWidget {
  final Function()? ontap;
  const DeleteButten({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: const Icon(
        Icons.delete,
        color: Colors.grey,
      ),
    );
  }
}
