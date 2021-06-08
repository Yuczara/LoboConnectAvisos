import 'package:flutter/material.dart';
import 'package:loboconnectnotif/models/aviso.dart';

class AvisoView extends StatefulWidget {
  final Aviso aviso;

  AvisoView(this.aviso);

  @override
  _AvisoViewState createState() => _AvisoViewState();
}


class _AvisoViewState extends State<AvisoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aviso.titulo),        
       backgroundColor: Colors.indigo[900],
       centerTitle: true,
      ),
      body: Column(
          children: <Widget>[
            Container(
              color: Colors.teal.shade100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.aviso.fechaPublicacion,
                        style: TextStyle(fontSize: 14.0, color: Colors.indigo[900]),
                        textAlign:TextAlign.right,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(padding:const EdgeInsets.all(10.0),
            child: Container(
                  child: Text(
                  widget.aviso.titulo,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    letterSpacing :1.0,
                  ),
                  textAlign:TextAlign.justify,
                  ),
              ),      ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  child: Text(
                  widget.aviso.descripcion,
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing :0.9,
                  ),
                  textAlign:TextAlign.justify,
                  ),
              ),              
            ),            
          ],
        ),
      );
  }
}
