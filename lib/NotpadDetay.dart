import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/main.dart';

import 'Nots.dart';

class NotepadDetay extends StatefulWidget {

  Nots note;
  NotepadDetay({required this.note});

  @override
  State<NotepadDetay> createState() => _NotepadDetayState();
}

class _NotepadDetayState extends State<NotepadDetay> {

  var tfNotBaslik=TextEditingController();
  var tfNotAltBaslik=TextEditingController();
  var tfNotIcerik=TextEditingController();


  var refNots=FirebaseDatabase.instance.ref().child("notlar");

  Future<void> sil(String not_id) async{
    refNots.child(not_id).remove();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
  }

  Future<void> guncelle(String not_id,String not_baslik, String not_Altbaslik,String not_icerik) async{
    var bilgi=HashMap<String,dynamic>();
    bilgi["not_baslik"]=not_baslik;
    bilgi["not_Altbaslik"]=not_Altbaslik;
    bilgi["not_icerik"]=not_icerik;

    refNots.child(not_id).update(bilgi);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
  }

  @override
  void initState() {
    super.initState();

    var not=widget.note;
    tfNotBaslik.text=not.not_baslik;
    tfNotAltBaslik.text=not.not_Altbaslik;
    tfNotIcerik.text=not.not_icerik;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Notepad Detay",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        actions: [
          TextButton(child: Text("Sil",style: TextStyle(color: Colors.black54),),
            onPressed:(){
                sil(widget.note.not_id);
            }
          ),
          TextButton(child: Text("Güncelle",style: TextStyle(color: Colors.black54),),
              onPressed:(){
                guncelle(widget.note.not_id, tfNotBaslik.text, tfNotAltBaslik.text, tfNotIcerik.text);
              }
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 40,left: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfNotBaslik,
                decoration: InputDecoration(hintText: "Başlık"),
              ),
              TextField(
                controller: tfNotAltBaslik,
                decoration: InputDecoration(hintText: "Alt Başlık"),
              ),
              TextField(
                controller: tfNotIcerik,
                decoration: InputDecoration(hintText: "Notunuz"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
