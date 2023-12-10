// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseMessagingPage extends StatefulWidget {
//   @override
//   _FirebaseMessagingPageState createState() => _FirebaseMessagingPageState();
// }

// class _FirebaseMessagingPageState extends State<FirebaseMessagingPage> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   @override
//   void initState() {
//     super.initState();
//     _setUpFirebaseMessaging();
//   }

//   Future<void> _setUpFirebaseMessaging() async {
//     // Request permission for handling notifications
//     await _firebaseMessaging.requestNotificationPermissions();

//     // Add the notification token to the user's document in Firestore
//     final token = await _firebaseMessaging.getToken();
//     // Store the token in Firestore or use it as needed

//     // Configure FirebaseMessaging to handle incoming messages
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         // Handle the incoming message when the app is in the foreground
//         _showNotification(message);
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         // Handle the incoming message when the app is launched from a terminated state
//         _handleNotificationRouting(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         // Handle the incoming message when the app is resumed from the background
//         _handleNotificationRouting(message);
//       },
//     );
//   }

//   void _showNotification(Map<String, dynamic> message) {
//     // Show a local notification using a notification library of your choice
//     // For example, you can use the flutter_local_notifications package
//   }

//   void _handleNotificationRouting(Map<String, dynamic> message) {
//     // Handle routing to the appropriate screen based on the notification content
//     // For example, if the notification is related to a scheduled program, navigate to the relevant screen
//     // You can use Navigator.push() to navigate to the desired screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Firebase Messaging')),
//       body: Center(
//         child: Text('This page is for handling Firebase Cloud Messaging'),
//       ),
//     );
//   }
// }
