import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physical_fitness_planner/constants.dart';

class CoachLoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const CoachLoginScreen({Key? key, this.onTap}) : super(key: key);

  @override
  _CoachLoginScreenState createState() => _CoachLoginScreenState();
}

class _CoachLoginScreenState extends State<CoachLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInCoach() async {
    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection(coachesCollection)
            .doc(userCredential.user!.uid)
            .get();
        if (userDoc.exists) {
          final role = userDoc.data()?['role'];

          if (role == 'coach') {
            // Sign-in successful, navigate to the coach's home screen
            Navigator.pushReplacementNamed(context, '/coach_home');
          } else {
            return displayMessage('Sorry you are not a coach');
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      displayMessage(e.code);
      // Handle sign-in errors
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach Login')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _signInCoach,
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: widget.onTap,
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
