import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String coachesCollection = 'coaches';

class AdminAuthScreen extends StatefulWidget {
  final void Function()? onTap;
  const AdminAuthScreen({Key? key, this.onTap}) : super(key: key);

  @override
  _AdminAuthScreenState createState() => _AdminAuthScreenState();
}

class _AdminAuthScreenState extends State<AdminAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ConfirmPassword = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _registerCoach() async {
    final String confirmPassword = _ConfirmPassword.text;
    final String password = _passwordController.text;

    if (_formKey.currentState!.validate() && password == confirmPassword) {
      // Form is valid, proceed with registration
      try {
        final String email = _emailController.text.trim();

        final String name = _nameController.text;

        final String photoUrl = _photoUrlController.text;

        // Create the user in Firebase Auth
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          // Registration successful, save additional coach data in Firestore
          await FirebaseFirestore.instance
              .collection(coachesCollection)
              .doc(userCredential.user!.uid)
              .set({
            'name': name,
            'phone Number':'',
            'specialization':'',
            'speciality':'',
            'role':'coach',

            // 'photoUrl': photoUrl,
            // Add other coach-specific data here
          });

          // Navigate to the coach's home screen
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/coach_home');
        }
      } on FirebaseAuthException catch (e) {
        print('Error registering coach: $e');
        displayMessage(e.code);
        // Handle registration errors
      }
    } else {
      displayMessage('Password Confirmation Error');
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(message)));
  }
  // ... existing code for the _signInCoach() method and the rest of the class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Registration')),
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
                  controller: _ConfirmPassword,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your birthday';
                    }
                    // You can add additional birthday validation here if needed
                    return null;
                  },
                ),
                // TextFormField(
                //   controller: _photoUrlController,
                //   decoration: const InputDecoration(labelText: 'Photo URL'),
                //   onSaved: (value) {
                //     _photoUrl = value!;
                //   },
                // ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _registerCoach,
                  child: const Text('Register'),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text('Already have an account? Log in here.'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
