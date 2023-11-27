import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String selectionName;
  final void Function()? onPressed;

  const MyTextBox(
      {super.key,
      required this.selectionName,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // selection Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //section name
              Text(
                selectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),

              // edit button

              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[400],
                  ))
            ],
          ),
          // text
          Text(text)
        ],
      ),
    );
  }
}
