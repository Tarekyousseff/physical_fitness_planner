import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/coach_register.dart';
import 'package:physical_fitness_planner/diet/Sorry_message.dart';
import 'package:physical_fitness_planner/diet/diet_workout_Create.dart';

class requestProfile extends StatefulWidget {
  final String name;
  final String Email;
  final String fitnessGoal;
  final String UserId;
  final String height;
  final String weight;
  final String fat;
  const requestProfile(
      {super.key,
      required this.name,
      required this.Email,
      required this.fitnessGoal,
      required this.UserId,
      required this.height,
      required this.weight,
      required this.fat});

  @override
  State<requestProfile> createState() => _requestProfileState();
}

class _requestProfileState extends State<requestProfile> {
  final User? _currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('customer Profile request'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello coach I am ${widget.name}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            GestureDetector(
              child: Text(
                'My Email Adress is ${widget.Email}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onTap: () {},
            ),
            Text(
              'My fitnessGoal is ${widget.fitnessGoal}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Text(
              'MY Height is:${widget.height}/ Weight:${widget.weight}/ Body Fat:${widget.fat}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Text(
              'I am Requesting a workout and diet Plan from your experince',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutCreate(
                                  userId: widget.UserId,
                                  email: widget.Email,
                                  fitnessGoal: widget.fitnessGoal,
                                  name: widget.name)));
                      FirebaseFirestore.instance
                          .collection(coachesCollection)
                          .doc(_currentuser?.uid)
                          .collection('request')
                          .doc(widget.UserId)
                          .delete();
                    },
                    icon: const Icon(
                      Icons.add_task,
                      color: Colors.green,
                      size: 50,
                    ),
                    label: Text(
                      'Accept',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.green[900]),
                    )),
                Center(
                  child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => sorryMessage(
                                    name: widget.name,
                                    Email: widget.Email,
                                    UserId: widget.UserId)));
                      },
                      icon: const Icon(
                        Icons.back_hand_sharp,
                        color: Colors.red,
                        size: 50,
                      ),
                      label: const Text(
                        'Reject',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.red),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
