import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchCoachDataFromFirebase(String coachId) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('coaches').doc(coachId).get();

  if (snapshot.exists) {
    return snapshot.data() ?? {}; // Return coach data as a Map
  } else {
    return {}; // Return an empty Map if coach data doesn't exist
  }
}


Future<void> updateCustomerProgram({
  required String customerId,
  required String workoutProgram,
  required String dietProgram,
}) async {
  try {
    await FirebaseFirestore.instance
        .collection('customer_programs')
        .doc(customerId)
        .set({
      'workoutProgram': workoutProgram,
      'dietProgram': dietProgram,
    }, SetOptions(merge: true));
  } catch (e) {
    print('Error updating program: $e');
    // Handle update errors
  }
}
