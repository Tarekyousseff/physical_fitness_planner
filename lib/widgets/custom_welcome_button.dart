// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomWelcomeButton extends StatefulWidget {
  final Color buttonColor;
  final String img;
  final String buttonLabel;
  final Color labeColor;
  final Color iconColor;
  void Function()? onTap;

  CustomWelcomeButton({
    Key? key,
    required this.buttonColor,
    required this.img,
    required this.buttonLabel,
    required this.labeColor,
    required this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomWelcomeButton> createState() => _CustomWelcomeButtonState();
}

class _CustomWelcomeButtonState extends State<CustomWelcomeButton>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadingAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100));
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController!);

    animationController?.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(offset: const Offset(1, 2), color: widget.buttonColor)
          ],
          color: widget.buttonColor,
          border: Border.all(
              style: BorderStyle.solid, color: Colors.black12, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.person,
              color: widget.iconColor,
              size: 70,
            ),
            AnimatedBuilder(
              animation: fadingAnimation!,
              builder: (context, child) => Opacity(
                opacity: fadingAnimation?.value,
                child: Text(
                  widget.buttonLabel,
                  style: TextStyle(
                      color: widget.labeColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
