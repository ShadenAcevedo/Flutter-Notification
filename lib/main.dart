import 'package:flutter/material.dart';
import 'package:notificaciones/services/push_notifications_service.dart';


import 'package:notificaciones/pages/home_screen.dart';
import 'package:notificaciones/pages/message_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationsService.initialzeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationsService.messagesStream.listen((message) {
      //print('MyApp ${message}');

      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      scaffoldKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications',
      initialRoute: 'home',
      navigatorKey: navigatorKey, // Navegar
      scaffoldMessengerKey: scaffoldKey, // Snacks
      routes: {
        'home' : (_) => HomeScreen(),
        'message' : (_) => MessageScreen()
      },
    );
  }
}
