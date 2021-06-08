import 'package:flutter/material.dart';
import 'package:loboconnectnotif/services/push_notification_service.dart';

 class MessagePage extends StatefulWidget {
 
  @override
  _MessagePageState createState() => _MessagePageState();
}


class _MessagePageState extends State<MessagePage> {
  void initState() { 
        super.initState();
        PushNotificationService.messageStream.listen((message) { 
          print('******MyApp: $message');
    });
  }
   @override
   Widget build(BuildContext context) {
       return Container(
         color: Colors.teal.shade100,
         child: AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(descripcion),
                //descripcion,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
    ),
       );
  }
}