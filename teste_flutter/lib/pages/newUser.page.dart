import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/cadastroNome.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';


class NovoUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: newUser(),
    );
  }
}

class newUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController user = TextEditingController();
    TextEditingController nome = TextEditingController();
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      String noome = nome.text;
      String uuser = user.text;

      if (uuser.length > 5 && noome.length> 5) {
        users
            .doc(uuser)
            .set({
          'nome': noome,
          'senha': "",
          'user': uuser
        })
            .then((value) => MaterialPageRoute(builder: (context) => AdminPage()))
            .catchError((error) => print("Failed to add user: $error"));
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            /*SizedBox(
             width: 128,
             height: 128,
             child: Image.asset(name),
           ),*/
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: user,
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
                  labelText: "Digite o usuario do aluno",
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
                  labelText: "Digite o nome do aluno",
                )
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: addUser,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Continuar",
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