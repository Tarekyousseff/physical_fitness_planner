import 'package:flutter/material.dart';
import 'package:physical_fitness_planner/coach%20screens/Profile_coach.dart';
import 'package:physical_fitness_planner/data/chat_Screen.dart';
import 'package:physical_fitness_planner/data/coash_customer.dart';
import 'package:physical_fitness_planner/diet/fitness_program_request.dart';

class CoachProfileScreen extends StatefulWidget {
  const CoachProfileScreen({super.key});

  @override
  State<CoachProfileScreen> createState() => _CoachProfileScreenState();
}

class _CoachProfileScreenState extends State<CoachProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Coach? coach = ModalRoute.of(context)?.settings.arguments as Coach;
    return Scaffold(
      appBar: AppBar(title: Text(coach.name)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ProfileCoach(
              showinformation: false,
              coach: coach,
            ),
            const SizedBox(height: 16),
            TabBar(controller: tabController, tabs: [
              Tab(
                child: Text('Profile'),
              ),
              Tab(
                child: Text('Connection'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
/*

 SingleChildScrollView(
              child: Column(
                children: [
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
                      child: const Text('Message the coach')),
                ],
              ),
            )
*/ 