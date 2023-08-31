import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/main.dart';

class NotepadKayit extends StatefulWidget {

  @override
  State<NotepadKayit> createState() => _NotepadKayitState();
}

class _NotepadKayitState extends State<NotepadKayit> {

  var tfNotBaslik=TextEditingController();
  var tfNotAltBaslik=TextEditingController();
  var tfNotIcerik=TextEditingController();

  var refNots=FirebaseDatabase.instance.ref().child("notlar");

  Future<void> kayit(String not_baslik, String not_Altbaslik,String not_icerik) async{
    var bilgi=HashMap<String,dynamic>();
    bilgi["not_id"]="";
    bilgi["not_baslik"]=not_baslik;
    bilgi["not_Altbaslik"]=not_Altbaslik;
    bilgi["not_icerik"]=not_icerik;

    refNots.push().set(bilgi);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Notepad Kayıt",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          kayit(tfNotBaslik.text, tfNotAltBaslik.text, tfNotIcerik.text);
        } ,
        tooltip: 'Not Kayit',
        icon: const Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
