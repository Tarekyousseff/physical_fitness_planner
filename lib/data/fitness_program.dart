import 'package:flutter/material.dart';

import 'package:physical_fitness_planner/data/coash_customer.dart';

class FitnessProgramRequestScreen extends StatefulWidget {
  final Coach coach;

  const FitnessProgramRequestScreen({super.key, required this.coach});

  @override
  _FitnessProgramRequestScreenState createState() => _FitnessProgramRequestScreenState();
}

class _FitnessProgramRequestScreenState extends State<FitnessProgramRequestScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fitnessGoalController = TextEditingController();

  void _submitRequest() {
    // Implement the logic to submit the fitness program request to the coach
    // You can send the data to the database or handle it in any other way as per your requirements
    // For example, you can use Firebase Firestore to store the requests and notify the coach.
    // After submitting the request, you can show a confirmation message to the customer.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Fitness Program')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Coach: ${widget.coach.name}'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Your Email'),
            ),
            TextField(
              controller: _fitnessGoalController,
              decoration: const InputDecoration(labelText: 'Your Fitness Goal'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitRequest,
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
