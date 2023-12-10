import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:physical_fitness_planner/constants.dart';

class ViewWorkoutPlansPage extends StatelessWidget {
  final String userId;

  const ViewWorkoutPlansPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Workout Plans'),
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseFirestore.instance
            .collection(customersCollection)
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final customerData = snapshot.data!;

          final workoutPlans = customerData['workoutPlan'] as List<dynamic>;

          if (workoutPlans.isEmpty) {
            return const Center(child: Text('No workout plans available.'));
          }

          return ListView.builder(
            itemCount: workoutPlans.length,
            itemBuilder: (context, index) {
              final plan = workoutPlans[index];

              return ListTile(
                title: Text('Workout Plan ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Workout: ${plan['Workout']}'),
                    Text('Exercise: ${plan['exercise']}'),
                    Text('Repetitions: ${plan['repetitions']}'),
                    Text('Weight: ${plan['weight']} kg'),
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
