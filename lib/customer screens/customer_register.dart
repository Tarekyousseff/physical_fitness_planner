import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class CustomerRegistrationScreen extends StatefulWidget {
  final void Function()? onTap;
  const CustomerRegistrationScreen({super.key, this.onTap});

  @override
  _CustomerRegistrationScreenState createState() =>
      _CustomerRegistrationScreenState();
}

class _CustomerRegistrationScreenState
    extends State<CustomerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerCustomer() async {
    final String confirmPassword = _confirmPassword.text;
    final String password = _passwordController.text;

    if (_formKey.currentState!.validate() && password == confirmPassword) {
      // Form is valid, proceed with registration
      try {
        final String email = _emailController.text.trim();

        final String name = _nameController.text;

        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          // Registration successful, save additional customer data in Firestore
          await FirebaseFirestore.instance
              .collection(customersCollection)
              .doc(userCredential.user!.uid)
              .set({
            'name': name,
            'phone Number': '',

            'role': 'customer',

            // Add other customer-specific data here
          });

          // Navigate to the customer's home screen
          Navigator.pushReplacementNamed(context, '/customer_home');
        }
      } on FirebaseAuthException catch (e) {
        print('Error registering customer: $e');
        displayMessage(e.code);
        // Handle registration errors
      }
    } else {
      displayMessage('error Password');
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
      appBar: AppBar(title: const Text('Customer Registration')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your full name';
                    }
                    // You can add additional validation for full name here if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // You can add additional email validation here if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    // You can add additional password validation here if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPassword,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'wrong password';
                    }
                    // You can add additional validation for full name here if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _registerCustomer,
                  child: const Text('Register'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: widget.onTap,
                  child: const Text('Already have an account? Log in here.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
