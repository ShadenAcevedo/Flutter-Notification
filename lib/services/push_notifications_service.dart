
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// SHA1: 16:06:86:22:A8:62:F7:9A:03:23:0A:7D:8D:5D:03:98:89:0A:6F:89

class PushNotificationsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  // Se llama cuando esta afuera de la app o terminada
  static Future _onBackgroundHandler(RemoteMessage message) async {
    //print('_onBackgroundHandler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  // Se llama  cuando la app está abierta
  static Future _onMessageHandler(RemoteMessage message) async {
    //print('_onMessageHandler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  // Se llama cuando abre la app
  static Future _onMessageOpenApp(RemoteMessage message) async {
    //print('_onMessageOpenApp ${message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto'] ?? 'No data');
  }

  static Future initialzeApp() async {

    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);
    
    // Handlers
    FirebaseMessaging.onBackgroundMessage( _onBackgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

    // Local Notifications
  }

  static closeStreams(){
    _messageStream.close();
  }
}