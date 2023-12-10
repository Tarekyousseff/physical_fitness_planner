import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_home_Screen.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_login_or_register.dart';

class coachAuth extends StatelessWidget {
  const coachAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //coach loggedin
          if (snapshot.hasData) {
            return const CoachHomeScreen();
          } else {
            return const coachLoginOrRegister();
          }
        },
      ),
    );
  }
}
