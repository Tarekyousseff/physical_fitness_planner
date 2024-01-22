import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:physical_fitness_planner/screens/coach%20screens/coach_login.dart';
import 'package:physical_fitness_planner/screens/coach%20screens/coach_login_or_register.dart';
import 'package:physical_fitness_planner/screens/coach%20screens/coach_register.dart';
import 'package:physical_fitness_planner/screens/customer%20screens/customer_auth.dart';
import 'package:physical_fitness_planner/screens/customer%20screens/customer_loginOrRegister.dart';
import 'package:physical_fitness_planner/screens/customer%20screens/customer_register.dart';
import 'package:physical_fitness_planner/widgets/custom_welcome_button.dart';
import 'package:physical_fitness_planner/widgets/decorationText.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/PFP__1_-removebg-preview.png',
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: 150,
                  child: CustomWelcomeButton(
                      iconColor: Colors.blue,
                      onTap: () {
                        Get.to(const coachLoginOrRegister());
                      },
                      labeColor: Colors.black,
                      buttonColor: Colors.red,
                      buttonLabel: 'Coach',
                      img: ''),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  height: 150,
                  child: CustomWelcomeButton(
                    iconColor: Colors.red,
                    onTap: () {
                      Get.to(const loginOrRegister());
                    },
                    labeColor: Colors.white,
                    buttonColor: Colors.blueAccent,
                    buttonLabel: 'Customer',
                    img: '',
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 100,
        ),
        const DecorationText(
            text: 'Physical Fitness Planner', textColor: Colors.black),
      ],
    );
  }
}
