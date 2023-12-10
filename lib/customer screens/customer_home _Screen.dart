import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_diet_view.dart';
import 'package:physical_fitness_planner/customer%20screens/customer_workout_plan.dart';
import 'package:physical_fitness_planner/screens/drawer.dart';
import 'package:physical_fitness_planner/screens/profile_page.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  User? _currentUser;
  bool _isWorkoutScheduled = false;
  bool _isDietScheduled = false;
  String _dietProgram = '';
  String _workoutProgram = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _checkScheduledPrograms();
    _setUpFirebaseMessaging();
    _fetchDietAndWorkoutPrograms();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = _auth.currentUser;
  }

  Future<void> _checkScheduledPrograms() async {
    final customerProgramsRef =
        _firestore.collection('customer_programs').doc(_currentUser?.uid).get();

    final customerProgramsSnapshot = await customerProgramsRef;
    final data = customerProgramsSnapshot.data();

    setState(() {
      _isWorkoutScheduled = data?['workoutScheduled'] ?? false;
      _isDietScheduled = data?['dietScheduled'] ?? false;
    });
  }

  Future<void> _setUpFirebaseMessaging() async {
    // Request permission for handling notifications
    await _firebaseMessaging.requestPermission(
        alert: true, badge: true, sound: true);

    // Add the notification token to the user's document in Firestore
    final token = await _firebaseMessaging.getToken();
    _firestore
        .collection('users')
        .doc(_currentUser?.uid)
        .update({'notificationToken': token});

    // Subscribe to a topic for receiving notifications related to scheduled programs
    _firebaseMessaging.subscribeToTopic('scheduled_programs');
  }

  Future<void> _fetchDietAndWorkoutPrograms() async {
    try {
      final customerDocRef =
          _firestore.collection('customers').doc(_currentUser?.uid);
      final customerSnapshot = await customerDocRef.get();

      setState(() {
        _dietProgram = customerSnapshot['dietProgram'] ?? '';
        _workoutProgram = customerSnapshot['workoutProgram'] ?? '';
      });
    } catch (e) {
      print('Error fetching programs: $e');
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Profile page
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Profilepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Home')),
      drawer: MyDrawer(
        profilepage: goToProfilePage,
        logout: signOut,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coach_list');
              },
              child: const Text('Find a Coach'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewWorkoutPlansPage(userId: _currentUser!.uid)));
              },
              child: const Text('View Workout Program'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewDietPlansPage(userId: _currentUser!.uid)));
              },
              child: const Text('View Diet Program'),
            ),
            const SizedBox(height: 20),
            if (_isWorkoutScheduled || _isDietScheduled)
              ElevatedButton(
                onPressed: () {
                  // Show notifications for scheduled programs
                  // You can use a local notification library for this purpose
                },
                child: const Text('Show Scheduled Programs'),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
