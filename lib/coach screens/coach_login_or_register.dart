import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_login.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_register.dart';

class coachLoginOrRegister extends StatefulWidget {
  const coachLoginOrRegister({super.key});

  @override
  State<coachLoginOrRegister> createState() => _coachLoginOrRegisterState();
}

class _coachLoginOrRegisterState extends State<coachLoginOrRegister> {
  bool showloginPage = true;
  void togglePages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return CoachLoginScreen(onTap: togglePages);
    } else {
      return CoachAuthScreen(onTap: togglePages);
    }
  }
}
