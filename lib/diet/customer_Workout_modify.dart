import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physical_fitness_planner/constants.dart';

class WorkoutPlanScreen extends StatelessWidget {
  final String userId;
  final String coachId;

  const WorkoutPlanScreen({
    Key? key,
    required this.userId, required this.coachId,
  }) : super(key: key);

  void _editWorkoutPlan(
      BuildContext context, String planId, Map<String, dynamic> planData) {
    // Implement edit logic here. You can navigate to an edit screen.
    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditWorkoutPlanScreen(planId, planData)));
  }

  void _deleteWorkoutPlan(BuildContext context, String planId) {
    FirebaseFirestore.instance
        .collection(customersCollection).doc().collection('customers')
        .doc(userId)
        .update({
      'workoutPlan': FieldValue.arrayRemove([planId]),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Workout plan deleted successfully.'),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error deleting workout plan: $error'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plan'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customerWorkoutPlan')
            .doc(coachId).collection('customers')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!;

          final workoutPlans = userData['workoutPlan'] as List<dynamic>;

          if (workoutPlans.isEmpty) {
            return const Center(child: Text('No workout plans available.'));
          }

          return ListView.builder(
            itemCount: workoutPlans.length,
            itemBuilder: (context, index) {
              final planId = workoutPlans[index];
              final planData = userData[planId];

              return ListTile(
                title: Text('Workout Plan ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Workout: ${planData['Workout']}'),
                    Text('Exercise: ${planData['exercise']}'),
                    Text('Repetitions: ${planData['repetitions']}'),
                    Text('Weight: ${planData['weight']} kg'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          _editWorkoutPlan(context, planId, planData),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteWorkoutPlan(context, planId),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
