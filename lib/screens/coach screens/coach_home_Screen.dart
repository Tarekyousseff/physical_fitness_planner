import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physical_fitness_planner/screens/coach%20screens/coach_profile_page.dart';
import 'package:physical_fitness_planner/screens/drawer.dart';

class CoachHomeScreen extends StatefulWidget {
  const CoachHomeScreen({super.key});

  @override
  _CoachHomeScreenState createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
  }

  void signout() {
    _auth.signOut();
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CoachProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach Home')),
      drawer: MyDrawer(
        profilepage: goToProfilePage,
        logout: signout,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/request_page');
              },
              child: const Text('Manage Programs'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coach_chat');
              },
              child: const Text('Chat with Customers'),
            ),
            // GestureDetector(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            //     child: Container(
            //       child: Image.asset('assets/WORKOUTLOGO.png'),
            //       width: 150,
            //       height: 150,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CoachCustomerListScreen(
            //                 coachId: _currentUser!.uid)),
            //         (route) => false);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
