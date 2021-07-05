import 'package:firebase_database/firebase_database.dart';
class Aviso{

  static const KEY = "key";
  static const DEPARTAMENTO = "departamento";
  static const DESCRIPCION = "descripcion";
  static const EMAIL = "email";
  static const EXIST = "exist";
  static const FECHAMODIFICACION = "fechaModificacion";
  static const FECHAPARAORDENAR = "fechaParaOrdenar";
  static const FECHAPUBLICACION = "fechaPublicacion";
  static const TITULO = "titulo";
  static const USUARIO = "usuario";

   //int date;
   String? key;
   String departamento;
   String descripcion;
   String email;
   String exist;
   String fechaModificacion;
   String fechaParaOrdenar;
   String fechaPublicacion;
   String titulo;
   String usuario;

  //Aviso(this.departamento,this.descripcion, this.email, this.exist, this.fechaModificacion, this.fechaParaOrdenar, this.fechaPublicacion, this.titulo, this.usuario);
  Aviso.fromSnapshot(DataSnapshot snap):
        this.key = snap.key,
        this.departamento = snap.value[DEPARTAMENTO],
        this.descripcion = snap.value[DESCRIPCION],
        this.email = snap.value[EMAIL],
        this.exist = snap.value[EXIST],
        this.fechaModificacion = snap.value[FECHAMODIFICACION],
        this.fechaParaOrdenar = snap.value[FECHAPARAORDENAR],
        this.fechaPublicacion = snap.value[FECHAPUBLICACION],
        this.titulo = snap.value[TITULO],
        this.usuario = snap.value[USUARIO];
        

  Map toMap(){
    return {DEPARTAMENTO: departamento ,DESCRIPCION:descripcion, EMAIL: email, EXIST: exist, FECHAMODIFICACION:fechaModificacion, FECHAPARAORDENAR:fechaParaOrdenar, FECHAPUBLICACION:fechaPublicacion, KEY: key};
  }
}