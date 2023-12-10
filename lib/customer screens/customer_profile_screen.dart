import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/constants.dart';

class CustomerProfileScreen extends StatelessWidget {
  final String customerId;

  const CustomerProfileScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    // Fetch customer profile and schedule based on the customer ID from Firestore
    // Replace 'customersCollection' with your actual Firestore collection name
    final DocumentReference customerRef =
        FirebaseFirestore.instance.collection(customersCollection).doc(customerId);

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Profile')),
      body: FutureBuilder<DocumentSnapshot>(
        future: customerRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final customerData = snapshot.data!.data() as Map<String, dynamic>;
            final customerName = customerData['name'];
            final customerSchedule = customerData['schedule'];

            // Display customer profile and schedule here
            return Column(
              children: [
                Text('Customer Name: $customerName'),
                Text('Customer Schedule: $customerSchedule'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat', arguments: customerId);
                  },
                  child: const Text('Chat'),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
