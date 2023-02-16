import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/greeenpage.dart';
import 'package:notifications/redpage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  log('Handling a background message ${message.notification!.title}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title

  description:
      'This channel is used for important notifications.', // description,
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// FlutterLocalNotificationsPlugin notificationsPlugin=FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await DotEnv().load('.env');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//below code is for local notifications
// AndroidInitializationSettings androidSetting=AndroidInitializationSettings("@mipmap/ic_launcher");
// DarwinInitializationSettings iosSetting=DarwinInitializationSettings();
// InitializationSettings settings=InitializationSettings(android: androidSetting,iOS: iosSetting); 
// bool? initialized= await notificationsPlugin.initialize(settings);
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
// flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//     AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
// log("Notification : $initialized");
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'red':(context) {
          return const Redpage();
        },
        'green':(context) {
          return const Greenpage();
        }
      },
      home: 
      // const Greenpage()
      const MyHomePage(title: 'Click icon below to send notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //below two methods are for local notification
// void showNotification()async{
//   AndroidNotificationDetails androidDetail=const AndroidNotificationDetails("Notification-id-prac", "Notification-name-prac",priority: Priority.max,importance: Importance.max);
//   DarwinNotificationDetails iosDetail=const DarwinNotificationDetails(presentAlert: true,presentBadge: true,presentSound: true);
//   NotificationDetails notificationDetails= NotificationDetails(android: androidDetail,iOS: iosDetail);
//   // DateTime scheduleDate=DateTime.now().add(const Duration(seconds: 1));
//   // await notificationsPlugin.zonedSchedule(0, "Sample Notification test",
//   //  "Notification Body", 
//   //  tz.TZDateTime.from(scheduleDate, tz.local),
  
//   // // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
//   //   notificationDetails,
//   //    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime ,
//   //    androidAllowWhileIdle: true);
//    await  notificationsPlugin.show(0, "Sample Notification test", "Notification Body", notificationDetails,payload: "Notty-payload");
// }
//    void CheckforNotification() async{
//    NotificationAppLaunchDetails? detailOfAppLaunch= await notificationsPlugin.getNotificationAppLaunchDetails();
//    if (detailOfAppLaunch!=null) {
//      if (detailOfAppLaunch.didNotificationLaunchApp) {
//        NotificationResponse? response = detailOfAppLaunch.notificationResponse;
//        if (response!=null) {
//          String? payload=response.payload;
//          log(payload!);
//        }
//      }
//    }
//    }
  
   @override
  void initState() {
    super.initState();
    // CheckforNotification();
        FirebaseMessaging.instance.requestPermission();
FirebaseMessaging.instance.getInitialMessage();
// this onmessage method is USED TO LISTEN MESSAGE WHEN THE APP IN THE FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.notification!.title!);
      log(message.notification!.body!);
      
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  
//this method trigger when the app is in the background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
log("on tap event of notification click is triggered");
Navigator.of(context).pushNamed(message.data['route']);
    });
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You will recieve messaege soon',
            ),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // showNotification();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.notifications),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  

}


// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:notifications/greeenpage.dart';
// import 'package:notifications/local_notification_service.dart';
// import 'package:notifications/redpage.dart';


// ///Receive message when app is in background solution for on message
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print(message.data.toString());
//   print(message.notification!.title);
// }

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         "red": (_) => const Redpage(),
//         "green": (_) => const Greenpage(),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     LocalNotificationService.initialize(context);

//     ///gives you the message on which user taps
//     ///and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if(message != null){
//         final routeFromMessage = message.data["route"];

//         Navigator.of(context).pushNamed(routeFromMessage);
//       }
//     });

//     ///forground work
//     FirebaseMessaging.onMessage.listen((message) {
//       if(message.notification != null){
//         print(message.notification!.body);
//         print(message.notification!.title);
//       }

//       LocalNotificationService.display(message);
//     });

//     ///When the app is in background but opened and user taps
//     ///on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       final routeFromMessage = message.data["route"];

//       Navigator.of(context).pushNamed(routeFromMessage);
//     });



//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return  Scaffold(
// appBar: AppBar(title: const Text("push notification"),),
//       body: const Padding(
//         padding: EdgeInsets.all(18.0),
//         child: Center(
//             child: Text(
//           "You will receive message soon",
//           style: TextStyle(fontSize: 34),
//         )),
//       ),
//     );
//   }
// }