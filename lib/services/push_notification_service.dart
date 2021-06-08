import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

String titulo="";
String descripcion="";

class PushNotificationService{
  static FirebaseMessaging messaging= FirebaseMessaging.instance;
  static String? token;

//Stream para manejar los datos 
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<dynamic> get messageStream => _messageStream.stream;

//Metodos para los diferentes tipos de notificaciones

//segundo plano
  static Future _backgroundHandler( RemoteMessage message)async{
    print('==============background Handler==============${message.messageId}');
    _messageStream.add(message.notification?.body?? 'No titulo');
    print(message.notification?.title?? 'no titulo');

    titulo= message.notification?.title?? 'no titulo';
    descripcion= message.notification?.body?? 'no descripcion';
  }

  static Future _onMessageHandler( RemoteMessage message)async{
    print('==============onMessageHandler============== ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body?? 'No titulo');
    print(message.notification?.title?? 'no titulo');
    
    titulo= message.notification?.title?? 'no titulo';
    descripcion= message.notification?.body?? 'no descripcion';
  }

//app abierta
  static Future _onMessageOpenApp( RemoteMessage message)async{
    print('==============onMessageOpenApp============== ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body?? 'No titulo');
    print(message.notification?.title?? 'no titulo');
  
  
    titulo= message.notification?.title?? 'no titulo';
    descripcion= message.notification?.body?? 'no descripcion';
  }

  static Future initializeApp() async{
    //push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    //TOKEN DEL DISPOSITIVO
    print('==========================TOKEN=============================');
    print('$token');
    

    //SUBSCRIPCION A TOPIC
    print('==========================SUBSCRIPCION=============================');
    print('FlutterFire Messaging Example: Subscribing to topic "TEST".');
    FirebaseMessaging.instance.subscribeToTopic('test');
    messaging.subscribeToTopic("test");


    //HANDLERS
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
   
  }

   static closeStreams(){
      _messageStream.close();
    }

}

