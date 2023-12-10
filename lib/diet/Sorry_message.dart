import 'package:flutter/material.dart';

class sorryMessage extends StatelessWidget {
  final String name;
  final String Email;

  final String UserId;
  const sorryMessage(
      {super.key,
      required this.name,
      required this.Email,
      required this.UserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 0),
              child: Container(
                child: const Text(
                  'Sorry The Coach program is full this month',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
            ),
            Container(
                child: Image.asset(
                    'assets/Black Minimalist Modern Business Namecard.png')),
          ],
        ),
      ),
    );
  }
}
