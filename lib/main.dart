import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_auth.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_home_Screen.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_list_page.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_profile_screen.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_register.dart';
import 'package:physical_fitness_planner/coach%20screens/diet_and_workout_screen.dart';
import 'package:physical_fitness_planner/coach%20screens/workout_plan_selection_screen.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_auth.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_home%20_Screen.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_register.dart';
import 'package:physical_fitness_planner/data/request_page.dart';
import 'package:physical_fitness_planner/screens/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        scaffoldBackgroundColor: Colors.amber,
      ),
      title: "my app",
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromARGB(20, 49, 48, 48),
        splashIconSize: 200,
        animationDuration: const Duration(seconds: 4),
        splash: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.black,
              child: Image(
                  image: AssetImage(
                'assets/PFP__1_-removebg-preview.png',
              )),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'welcome',
            //   style: TextStyle(
            //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            // ),
          ],
        ),
        nextScreen: const LandingScreen(),
      ),
      routes: {
        '/customer_register': (context) => const CustomerRegistrationScreen(),

        '/coach_auth': (context) => const CoachAuthScreen(),
        // Add home screens for customers and coaches
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/coach_home': (context) => const CoachHomeScreen(),
        '/registration': (context) => const coachAuth(),
        '/coach_list': (context) => const CoachListPage(),
        '/customer_login': (context) => const customerAuth(),
        '/workout_plan_selection': (context) =>
            const WorkoutPlanSelectionScreen(),
        '/diet_and_workout': (context) => const DietAndWorkoutScreen(),
        '/coach_profile_screen': (context) => const CoachProfileScreen(),
        '/request_page': (context) => const requestPage(),
      },
    );
  }
}
