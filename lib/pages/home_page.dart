import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loboconnectnotif/models/aviso.dart';

import 'package:loboconnectnotif/pages/message_page.dart';
import 'package:loboconnectnotif/pages/view_notification.dart';
import 'package:loboconnectnotif/services/push_notification_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "avisos_lc";
  List<Aviso> avisoList = <Aviso>[];


  @override
  // ignore: must_call_super
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);

  
        //context
        PushNotificationService.messageStream.listen((message) { 
          print('******MyApp: $message');
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()),);
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avisos"),
        backgroundColor: Colors.indigo.shade900,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.teal.shade100,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: avisoList.isEmpty,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                                  "No tienes avisos",
                                  style: TextStyle(fontSize: 25.0, color: Colors.blueGrey,height:15.0),
                                ),
                  //child: CircularProgressIndicator(),
                ),
              ),
            ),

            Visibility(
              visible: avisoList.isNotEmpty,
              child: Flexible(
                  child: FirebaseAnimatedList(                    
                      query: _database.reference().child('avisos_lc'),
                      //reverse: true,
                        itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AvisoView(avisoList.reversed.toList()[index])));
                                },
                                title: Text(
                                  avisoList.reversed.toList()[index].titulo,
                                  style: TextStyle(
                                      fontSize: 22.0, fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  avisoList.reversed.toList()[index].fechaPublicacion,
                                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 14.0),
                                child: Text(avisoList.reversed.toList()[index].descripcion, style: TextStyle(fontSize: 18.0),),
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

   _childAdded(Event event) {
    setState(() {
      avisoList.add(Aviso.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedAviso = avisoList.singleWhere((aviso){
      return aviso.key == event.snapshot.key;
    });

    setState(() {
      avisoList.removeAt(avisoList.indexOf(deletedAviso));
    });
  }

  void _childChanged(Event event) {
    var changedAviso = avisoList.singleWhere((aviso){
      return aviso.key == event.snapshot.key;
    });

    setState(() {
      avisoList[avisoList.indexOf(changedAviso)] = Aviso.fromSnapshot(event.snapshot);
    });
  }
  
}


//avisoList.reversed.toList()[index]