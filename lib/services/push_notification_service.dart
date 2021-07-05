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
    _messageStream.add(message.notification?.body?? 'Nuevo Aviso');
    print(message.notification?.title?? 'Nuevo Aviso');

    titulo= message.notification?.title?? 'Nuevo Aviso';
    descripcion= message.notification?.body?? 'Revisa tu bandeja de avisos.';
  }

  static Future _onMessageHandler( RemoteMessage message)async{
    print('==============onMessageHandler============== ${message.messageId}');
    print(message.data);

    _messageStream.add(message.notification?.body?? 'Nuevo Aviso');
    print(message.notification?.title?? 'Nuevo Aviso');
    
    titulo= message.notification?.title?? 'Nuevo Aviso';
    descripcion= message.notification?.body?? 'Revisa tu bandeja de avisos.';
  }

//app abierta
  static Future _onMessageOpenApp( RemoteMessage message)async{
    print('==============onMessageOpenApp============== ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body?? 'Nuevo Aviso');
    print(message.notification?.title?? 'Nuevo Aviso');
  
  
    titulo= message.notification?.title?? 'Nuevo Aviso';
    descripcion= message.notification?.body?? 'Revisa tu bandeja de avisos.';
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
