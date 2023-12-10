import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/constants.dart';
import 'package:physical_fitness_planner/diet/customer_Workout_modify.dart';

class CoachCustomerListScreen extends StatelessWidget {
  final String coachId;

  const CoachCustomerListScreen({super.key, required this.coachId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(customersCollection)
            .where('coachid', isEqualTo: coachId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final customerDocs = snapshot.data!.docs;

          if (customerDocs.isEmpty) {
            return const Center(child: Text('No customers found.'));
          }

          return ListView.builder(
            itemCount: customerDocs.length,
            itemBuilder: (context, index) {
              final customerDoc = customerDocs[index];
              final customerId = customerDoc.id;
              final customerName = customerDoc[
                  'name']; // Replace with the actual field name for the customer's name

              return ListTile(
                title: Text(customerName),
                onTap: () {
                  // Navigate to the customer details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutPlanScreen(
                        userId: customerId,
                        coachId: coachId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
