// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static void initialize(BuildContext context) {
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings("@mipmap/ic_launcher"));

//     _notificationsPlugin.initialize(initializationSettings,
//     onDidReceiveNotificationResponse: (route) {

//       if(route != null){
//         // log(route.payload);
//         // Navigator.of(context).pushNamed(route.payload);
      
//     }}
//     // onSelectNotification: (String? route
//     // ) async{
//     //   if(route != null){
//     //     Navigator.of(context).pushNamed(route);
//     //   }
//     // }
//     );
//   }

//   static void display(RemoteMessage message) async {

//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/1000;

//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "high_importance_channel",
//           "High Importance Notifications",
//           importance: Importance.max,
//           priority: Priority.high,
//         )
//       );


//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data["route"],
//       );
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// }