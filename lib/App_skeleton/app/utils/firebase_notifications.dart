import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> setupInteractedMessage() async {
  // await Firebase.initializeApp();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  _fcm.getToken().then((token) {
    print("firebaseToken... $token");
  });
  // show notification to user
  NotificationSettings settings = await _fcm.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission: ${settings.authorizationStatus}');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print(
        'User granted provisional permission: ${settings.authorizationStatus}');
  } else {
    print(
        'User declined or has not accepted permission: ${settings.authorizationStatus}');
  }

  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage = await _fcm.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  ///forground messaging
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
    print(event.data.values);

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text("onMessage"),
    //         content: Text(event.notification!.body!),
    //         actions: [
    //           TextButton(
    //             child: Text("Ok"),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           )
    //         ],
    //       );
    //     });
  });
  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

void _handleMessage(RemoteMessage message) {
  if (message.data['type'] == 'chat') {
    // Navigator.pushNamed(context, '/chat',
    //   arguments: ChatArguments(message),
    // );
  }
}
