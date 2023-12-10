import 'package:flutter/material.dart';

class textBox extends StatelessWidget {
  final String text;
  final String SectionName;
  void Function()? onPressed;

  textBox(
      {super.key,
      required this.text,
      required this.SectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white30,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SectionName,
                style: TextStyle(color: Colors.grey[600]),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.edit, color: Colors.grey[600])),
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
