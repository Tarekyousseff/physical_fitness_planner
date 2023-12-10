import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/data/chat_Screen.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';
import 'package:physical_fitness_planner/diet/fitness_program_request.dart';

class CoachProfileScreen extends StatelessWidget {
  const CoachProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Coach? coach = ModalRoute.of(context)?.settings.arguments as Coach;
    return Scaffold(
      appBar: AppBar(title: const Text('Coach Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(coachPhotoUrl),
            ),
            const SizedBox(height: 16),
            Text(coach.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${coach.specialization}/' + coach.speciality),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the WorkoutPlanSelectionScreen
                // Navigator.pushNamed(context, '/workout_plan_selection');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FitnessProgramRequestScreen(coach: coach),
                    ));
              },
              child: const Text('Select Workout Plan'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                              coachId: coach
                                  .id))); // Replace 'COACH_USER_ID' with the actual coach's user ID
                },
                child: const Text('Message the coach'))
          ],
        ),
      ),
    );
  }
}
