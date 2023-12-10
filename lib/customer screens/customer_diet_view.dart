import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewDietPlansPage extends StatelessWidget {
  final String userId;

  const ViewDietPlansPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Diet Plans'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final customerData = snapshot.data!;

          final dietPlans = customerData['dietPlan'] as List<dynamic>;

          if (dietPlans.isEmpty) {
            return const Center(child: Text('No diet plans available.'));
          }

          return ListView.builder(
            itemCount: dietPlans.length,
            itemBuilder: (context, index) {
              final plan = dietPlans[index];

              return ListTile(
                title: Text('Diet Plan ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Meal: ${plan['meal']}'),
                    Text('Food: ${plan['foodItems']}'),
                    Text('Calories: ${plan['portions']}'),
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
