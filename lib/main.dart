
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notepad/NotepadKayit.dart';
import 'package:notepad/NotpadDetay.dart';
import 'package:notepad/Nots.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {


  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  
  var refNots=FirebaseDatabase.instance.ref().child("notlar");

  Future<bool> uygulamayiKapat()async{
    await exit(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            uygulamayiKapat();
      },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Notepad"),
      ),
      body:WillPopScope(
        onWillPop: uygulamayiKapat,
        child: StreamBuilder<DatabaseEvent>(
          stream: refNots.onValue,
          builder: (context,event){
            if(event.hasData){
              var notlarListesi=<Nots>[];
              var gelenDeger=event.data!.snapshot.value as dynamic;
              if(gelenDeger!=null){
                gelenDeger.forEach((key,nesne){
                  var gelenNot=Nots.fromJson(key, nesne);
                  notlarListesi.add(gelenNot);
                });
              }
              return ListView.builder(
                itemCount: notlarListesi!.length,
                itemBuilder: (context,indeks){
                  var not=notlarListesi[indeks];
                  return GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotepadDetay(note: not,)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(not.not_baslik,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Text(not.not_Altbaslik,style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotepadKayit()));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
