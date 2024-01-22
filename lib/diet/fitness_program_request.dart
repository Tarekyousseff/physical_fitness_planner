import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/screens/coach%20screens/coach_register.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';

class FitnessProgramRequestScreen extends StatefulWidget {
  final Coach coach;

  const FitnessProgramRequestScreen({super.key, required this.coach});

  @override
  _FitnessProgramRequestScreenState createState() =>
      _FitnessProgramRequestScreenState();
}

class _FitnessProgramRequestScreenState
    extends State<FitnessProgramRequestScreen> {
  final _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fitnessGoalController = TextEditingController();
  final TextEditingController _BodyWeightlController = TextEditingController();
  final TextEditingController _BodyheightlController = TextEditingController();
  final TextEditingController _BodylFatController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;
  void getCurrentUser() async {
    _currentUser = _auth.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void _submitRequest() async {
    // Implement the logic to submit the fitness program request to the coach
    // You can send the data to the database or handle it in any other way as per your requirements
    // For example, you can use Firebase Firestore to store the requests and notify the coach.
    // After submitting the request, you can show a confirmation message to the customer.

    await FirebaseFirestore.instance
        .collection(coachesCollection)
        .doc(widget.coach.id)
        .collection('request')
        .doc(_currentUser!.uid)
        .set({
      'CustomerName': _nameController.text,
      'CustomerEmail': _emailController.text,
      'FitnessGoal': _fitnessGoalController.text,
      'weight': _BodyWeightlController.text,
      'height': _BodyheightlController.text,
      'fat': _BodylFatController.text,
      'UsersID': _currentUser!.uid,
      'UserName': _currentUser!.displayName,
    });
    Navigator.pushReplacementNamed(context, '/diet_and_workout');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Fitness Program')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' ${widget.coach.name}'),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Your Full Name'),
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Your Email'),
              ),
              TextField(
                controller: _fitnessGoalController,
                decoration: const InputDecoration(
                    labelText: 'Your Fitness Goal',
                    hintText: 'Cutting,Bulking,Strength,power'),
              ),
              TextField(
                  controller: _BodyWeightlController,
                  decoration: const InputDecoration(
                    labelText: 'Body Weight',
                  )),
              TextField(
                  controller: _BodyheightlController,
                  decoration: const InputDecoration(
                    labelText: 'Body Height',
                  )),
              TextField(
                  controller: _BodylFatController,
                  decoration: const InputDecoration(
                    labelText: 'Body Fat',
                  )),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
