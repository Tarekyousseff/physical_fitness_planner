import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_home%20_Screen.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_loginOrRegister.dart';

class customerAuth extends StatelessWidget {
  const customerAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User loged in
          if (snapshot.hasData) {
            return const CustomerHomeScreen();
          } else {
            return const loginOrRegister();
          }
        },
      ),
    );
  }
}
