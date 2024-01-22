import 'package:flutter/material.dart';

class WorkoutPlanSelectionScreen extends StatelessWidget {
  const WorkoutPlanSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan Selection')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Choose your desired workout plan:', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          // Add widgets to represent different workout plans
          // For example, use checkboxes or radio buttons to allow selection
          // Add appropriate logic to handle workout plan selection
          // You can use state management (e.g., Provider, Bloc) to handle the selected plan
          // For this example, let's assume there are three workout plans: Beginner, Intermediate, and Advanced.
          
          ElevatedButton(
            onPressed: () {
              // Simulate the "fake" payment process
              // After pressing this button, navigate to the DietAndWorkoutScreen
              Navigator.pushNamed(context, '/diet_and_workout');
            },
            child: const Text('Proceed to Payment'),
          ),
        ],
      ),
    );
  }
}
