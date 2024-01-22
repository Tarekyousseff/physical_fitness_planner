import 'package:flutter/material.dart';

class DecorationText extends StatefulWidget {
  final String text;
  final Color textColor;

  const DecorationText(
      {super.key, required this.text, required this.textColor});

  @override
  State<DecorationText> createState() => _DecorationTextState();
}

class _DecorationTextState extends State<DecorationText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: widget.textColor),
    );
  }
}
