import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/constants.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';

class CoachListPage extends StatefulWidget {
  const CoachListPage({super.key});

  @override
  _CoachListPageState createState() => _CoachListPageState();
}

class _CoachListPageState extends State<CoachListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(coachesCollection)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching coaches.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Retrieve the list of coaches from the Firestore snapshot
          final coaches = snapshot.data?.docs;

          if (coaches == null || coaches.isEmpty) {
            return const Center(child: Text('No coaches found.'));
          }

          return ListView.builder(
            itemCount: coaches.length,
            itemBuilder: (context, index) {
              final coachData = coaches[index].data() as Map<String, dynamic>;

              // Safely access the values using the null-aware operator (?)
              final name = coachData['name'] ?? '';
              final specialization = coachData['specialization'] ?? '';
              final speciality = coachData['speciality'] ?? '';
              final photoUrl = coachData['photoUrl'] ?? '';

              // Create Coach object from the data retrieved from Firestore
              Coach coach = Coach(
                city: 'Tripoli',
                country: 'Lebanon',
                coachSocialMedia: [
                  SocialMedia(
                      url: 'https://www.instagram.com/',
                      picture: 'assets/instagramlogo.jpg'),
                  SocialMedia(
                      url: 'https://www.facebook.com/',
                      picture: 'assets/faceicon.png')
                ],
                id: coaches[index].id,
                dateOfB: '13/5/1999',
                email: 'Tarek@gmail.com',
                gender: 'Male',
                phoneNumber: '79136181',
                name: name,
                specialization: specialization,
                speciality: speciality,
                photoUrl: photoUrl,
              );

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
                title: Text(name),
                subtitle: Text(specialization),
                onTap: () {
                  // Navigate to the coach details page or chat page
                  // You can use Navigator.push() to navigate to the desired page
                  Navigator.pushNamed(context, '/coach_profile_screen',
                      arguments: Coach(
                        city: 'Tripoli',
                        country: 'Lebanon',
                        coachSocialMedia: [
                          SocialMedia(
                              url: 'https://www.instagram.com/', picture: ''),
                          SocialMedia(
                              url: 'https://www.facebook.com/',
                              picture: 'assets/faceicon.png')
                        ],
                        id: coaches[index].id,
                        dateOfB: '13/5/1999',
                        email: 'Tarek@gmail.com',
                        gender: 'Male',
                        phoneNumber: '79136181',
                        name: name,
                        specialization: specialization,
                        speciality: speciality,
                        photoUrl: photoUrl,
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
