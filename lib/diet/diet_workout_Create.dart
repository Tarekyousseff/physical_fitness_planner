import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/constants.dart';
import 'package:physical_fitness_planner/diet/diet_plan%20create.dart';

class WorkoutCreate extends StatefulWidget {
  final String userId;
  final String email;
  final String fitnessGoal;
  final String name;

  const WorkoutCreate({
    Key? key,
    required this.userId,
    required this.email,
    required this.fitnessGoal,
    required this.name,
  }) : super(key: key);

  @override
  _WorkoutCreateState createState() => _WorkoutCreateState();
}

class _WorkoutCreateState extends State<WorkoutCreate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Create a list to store workout plan details
  List<Map<String, dynamic>> workoutPlan = [];

  void _addExercise(String exercise, String Workout, int repetitions, int Sets,
      double weight) async {
    final customerDocRef = FirebaseFirestore.instance
        .collection(customersCollection)
        .doc(widget.userId);
    workoutPlan.add({
      'Workout': Workout,
      'exercise': exercise,
      'repetitions': repetitions,
      'Sets': Sets,
      'weight': weight,
    });

    await customerDocRef.update({
      'workoutPlan': FieldValue.arrayUnion([workoutPlan.last]),
    });

    // Update UI

    setState(() {});
  }

  Future<void> _showExerciseDialog() async {
    String workoutName = '';
    String exerciseName = '';
    int repetitions = 0;
    int sets = 0;
    double weight = 0.0;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Workout'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Workout Name'),
                  onChanged: (value) {
                    workoutName = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Exercise Name'),
                  onChanged: (value) {
                    exerciseName = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Repetitions'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    repetitions = int.tryParse(value) ?? 0;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Sets'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    repetitions = int.tryParse(value) ?? 0;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    weight = double.tryParse(value) ?? 0.0;
                  },
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
                _addExercise(
                    exerciseName, workoutName, repetitions, sets, weight);
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
        title: const Text('Create Workout Plan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExerciseDialog(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Workout Plan:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: workoutPlan.length,
                itemBuilder: (context, index) {
                  final Workout = workoutPlan[index]['Workout'];
                  final exercise = workoutPlan[index]['exercise'];
                  final repetitions = workoutPlan[index]['repetitions'];
                  final weight = workoutPlan[index]['weight'];

                  return ListTile(
                    title: Text('Workout: $Workout'),
                    subtitle: Text(
                      'Exercise : $exercise ,Repetitions: $repetitions, Weight: $weight kg',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => DietPlanCreate(
                          userId: widget.userId,
                          email: widget.email,
                          fitnessGoal: widget.fitnessGoal,
                          name: widget.name))));
                },
                child: const Text('Diet plan Create'))
          ],
        ),
      ),
    );
  }
}
