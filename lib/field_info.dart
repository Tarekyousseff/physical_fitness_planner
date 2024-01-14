import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';

class FieldInfo extends StatefulWidget {
  final String title;
  final String? info;
  final List<SocialMedia>? socialLinks;
  const FieldInfo(
      {super.key, required this.title, this.info, this.socialLinks});

  @override
  State<FieldInfo> createState() => _FieldInfoState();
}

class _FieldInfoState extends State<FieldInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            '${widget.info}',
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
