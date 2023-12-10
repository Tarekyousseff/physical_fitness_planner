import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_register.dart';
import 'package:physical_fitness_planner/data/request_profile.dart';

class requestPage extends StatefulWidget {
  const requestPage({super.key});

  @override
  State<requestPage> createState() => _requestPageState();
}

class _requestPageState extends State<requestPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  User? _currentUser;
  void getCurrentUser() async {
    _currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('customers request page'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(coachesCollection)
            .doc(_currentUser?.uid)
            .collection('request')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('error fetching customers request'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final request = snapshot.data?.docs;
          if (request == null || request.isEmpty) {
            return const Center(child: Text('no requests found'));
          }

          return ListView.builder(
            itemCount: request.length,
            itemBuilder: (context, Index) {
              final requestData = request[Index].data() as Map<String, dynamic>;

              final name = requestData['CustomerName'] ?? '';
              final Email = requestData['CustomerEmail'] ?? '';
              final FitnessGoal = requestData['FitnessGoal'] ?? '';
              final height = requestData['height'] ?? '';
              final weight = requestData['weight'] ?? '';
              final Fat = requestData['fat'] ?? '';
              final UserID = requestData['UsersID'] ?? '';

              return ListTile(
                title: Text(name),
                subtitle: Text(UserID),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => requestProfile(
                                name: name,
                                Email: Email,
                                fitnessGoal: FitnessGoal,
                                UserId: UserID,
                                fat: Fat,
                                height: height,
                                weight: weight,
                              )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
