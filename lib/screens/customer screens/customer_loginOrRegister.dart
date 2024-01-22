import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/screens/customer%20screens/customer_login.dart';
import 'package:physical_fitness_planner/screens/customer%20screens/customer_register.dart';

class loginOrRegister extends StatefulWidget {
  const loginOrRegister({super.key});

  @override
  State<loginOrRegister> createState() => _loginOrRegisterState();
}

class _loginOrRegisterState extends State<loginOrRegister> {
  bool showloginPage = true;

  void togglePages() {
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage) {
      return customerLoginScreen(onTap: togglePages,);
    } else {
      return CustomerRegistrationScreen(onTap: togglePages,);
    }
    
  }
}
