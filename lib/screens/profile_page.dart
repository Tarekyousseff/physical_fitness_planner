import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/constants.dart';
import 'package:physical_fitness_planner/data/Text_box.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection =
      FirebaseFirestore.instance.collection(customersCollection);
  Future<void> editFiled(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit$field'),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.red),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.amber)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.green),
              ))
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile Page',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: FirebaseFirestore.instance
                .collection(customersCollection)
                .doc(currentUser.uid)
                .snapshots(),
            builder: (context, Snapshot) {
              // if we have data
              if (Snapshot.hasData) {
                // ignore: non_constant_identifier_names
                final CustomerData =
                    Snapshot.data!.data() as Map<String, dynamic>;
                //
                return ListView(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    //profile picture
                    const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 252, 0, 0),
                      size: 80,
                    ),
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        'My Details:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    textBox(
                      text: CustomerData['name'],
                      SectionName: 'User Name:',
                      onPressed: () => editFiled('name'),
                    ),
                    textBox(
                        text: CustomerData['phone Number'],
                        SectionName: 'Phone Number',
                        onPressed: () => editFiled('phone Number'))
                  ],
                );
              } else if (Snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error${Snapshot.error}',
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
