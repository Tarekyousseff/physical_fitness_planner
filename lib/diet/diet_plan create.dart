import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:physical_fitness_planner/constants.dart';

class DietPlanCreate extends StatefulWidget {
  final String userId;
  final String email;
  final String fitnessGoal;
  final String name;

  const DietPlanCreate({
    Key? key,
    required this.userId,
    required this.email,
    required this.fitnessGoal,
    required this.name,
  }) : super(key: key);

  @override
  _DietPlanCreateState createState() => _DietPlanCreateState();
}

class _DietPlanCreateState extends State<DietPlanCreate> {
  User? _currentUser;
  void getCurrentUser() async {
    _currentUser = _auth.currentUser;
  }

  //add coach id to the customer data so he can access his workout

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _mealController = TextEditingController();
  final TextEditingController _foodItemsController = TextEditingController();
  final TextEditingController _portionsController = TextEditingController();

  List<Map<String, dynamic>> dietPlan = [];

  void _addMeal(String meal, String foodItems, String portions) async {
    final customerDocRef = FirebaseFirestore.instance
        .collection(customersCollection)
        .doc(widget.userId);

    dietPlan.add({
      'meal': meal,
      'foodItems': foodItems,
      'portions': portions,
    });

    // Update Firestore document
    await customerDocRef.update({
      'dietPlan': FieldValue.arrayUnion([dietPlan.last]),
    });

    // Clear input fields
    _mealController.clear();
    _foodItemsController.clear();
    _portionsController.clear();

    // Update UI
    setState(() {});
  }

  Future<void> _showMealDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Meal'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _mealController,
                  decoration: const InputDecoration(
                      labelText: 'Meal (e.g., Breakfast)'),
                ),
                TextFormField(
                  controller: _foodItemsController,
                  decoration: const InputDecoration(labelText: 'Food Items'),
                ),
                TextFormField(
                  controller: _portionsController,
                  decoration: const InputDecoration(labelText: 'Portions'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addMeal(
                  _mealController.text,
                  _foodItemsController.text,
                  _portionsController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Diet Plan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMealDialog(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Diet Plan:'),
            Expanded(
              child: ListView.builder(
                itemCount: dietPlan.length,
                itemBuilder: (context, index) {
                  final meal = dietPlan[index]['meal'];
                  final foodItems = dietPlan[index]['foodItems'];
                  final portions = dietPlan[index]['portions'];

                  return ListTile(
                    title: Text('Meal: $meal'),
                    subtitle:
                        Text('Food Items: $foodItems, Portions: $portions'),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.done), // Replace with your desired icon
                label: const Text('Done'), // Replace with your desired label
              ),
            )
          ],
        ),
      ),
    );
  }
}
