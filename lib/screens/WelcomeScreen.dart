import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/adminScreens/admin_login.dart';
import 'package:physical_fitness_planner/adminScreens/admin_register.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: const Text('Welcome to physical fitness planner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/PFP__1_-removebg-preview.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer_login');
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Text(
                'I am a Customer',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: const Text(
                'I am a Coach',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => AdminAuthScreen(
            //             onTap: () => Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                     builder: (context) => AdminLoginScreen())))));
            //   },
            //   style: ElevatedButton.styleFrom(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 27, vertical: 20),
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(8))),
            //   child: const Text(
            //     'admin',
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
