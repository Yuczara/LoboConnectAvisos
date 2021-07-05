import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loboconnectnotif/models/aviso.dart';
import 'package:loboconnectnotif/pages/home_page.dart';
import 'package:loboconnectnotif/pages/message_page.dart';
import 'package:loboconnectnotif/pages/view_notification.dart';
import 'package:loboconnectnotif/services/push_notification_service.dart';
 var mensaje;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(MyApp());
}  
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp>{
     @override

     //COMPROBAR SI HAY NOTIFICACIONES
     void initState() { 
        super.initState();
        //context
        PushNotificationService.messageStream.listen((message) { 
           print('******MyApp: $message');
           Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()),);
    });
  }
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'home',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
      },
      
    );
  }
  
}