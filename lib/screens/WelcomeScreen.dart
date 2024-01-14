import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/adminScreens/admin_login.dart';
import 'package:physical_fitness_planner/adminScreens/admin_register.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_login.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_login.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  String dropdownvalue = 'Customer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/PFP__1_-removebg-preview.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('I am:'),
                        DropdownButton<String>(
                          value: dropdownvalue,
                          icon: const Icon(Icons.person, color: Colors.red),
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          items: const [
                            DropdownMenuItem<String>(
                              child: Text('Coach'),
                              value: 'Coach',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Customer'),
                              value: 'Customer',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              dropdownvalue = value!;
                              print(dropdownvalue);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (dropdownvalue == 'Customer') ...[
              Text('Welcome Back '),
              customerLoginScreen()
            ] else ...[
              Text('Welcome back Coach'),
              const CoachLoginScreen(),
            ],
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
