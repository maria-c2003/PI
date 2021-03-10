import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/cadastroNome.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';


class NovoVideo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: NewVideo(),
    );
  }
}

class NewVideo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController url = TextEditingController();
    TextEditingController nome = TextEditingController();
    CollectionReference video = FirebaseFirestore.instance.collection('videos');
    var now = DateTime.now();

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      String urrl = url.text;
      String noome = nome.text;

      if (urrl.length > 5 && noome.length> 5) {
        video
            .doc()
            .set({
          'nome': noome,
          'url': urrl,
          'data': now
        })
            .then((value) => {
          print("login"),
        }, )
            .catchError((error) => print("Failed to add user: $error"));
      }
      MaterialPageRoute(builder: (context) => AdminPage());
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: url,
                autofocus: false,
                readOnly: false,
                obscureText: false,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: "Digite o url do video",
                )
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: nome,
                autofocus: false,
                readOnly: false,
                obscureText: false,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(500),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  labelText: "Digite o nome do video",
                )
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: addUser,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Salvar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
          ],
        ),
      ),
    );
  }
}