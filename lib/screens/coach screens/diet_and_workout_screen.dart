import 'package:flutter/material.dart';

class DietAndWorkoutScreen extends StatelessWidget {
  const DietAndWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diet and Workout Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Congratulations! You have selected the workout plan.'),
          const Text(
              'Now, you can access your diet plan and workout schedule after the coach accept and read your requirements'),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/customer_home');
              },
              label: const Text('HomeScreen'),
              icon: const Icon(Icons.home),
            ),
          )

          // Add widgets to display the diet plan and workout schedule here
        ],
      ),
    );
  }
}
