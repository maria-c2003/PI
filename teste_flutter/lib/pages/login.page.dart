import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:teste_flutter/pages/aluno.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';
import 'package:teste_flutter/pages/cadastro.page.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Const(),
    );
  }
}

class Const extends StatelessWidget {
  TextEditingController user = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .doc("mac")
          .set({'nome': "Maria Clara dos Santos", 'user': "mac"})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Future<void> login() {
      String nome = user.text;
      String pass = senha.text;
      String passFire;
      if (nome == 'admin' && pass == 'admin2021'){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()));
      } else {
        FirebaseFirestore.instance
            .collection('User')
            .doc(nome)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            passFire = documentSnapshot.data()['senha'];
            print('Document data: ${passFire}');
            if (passFire == null) {
              print('sem senha');
            } else if (passFire == pass) {
              print('senha certa');
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlunoPage()));
            } else {
              print('Senha errada');
            }
          } else {
            print('sem cadastro');
          }
        });
      }
    };

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 300, left: 40, right: 40),
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
                autofocus: true,
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
                  labelText: 'Usuario',
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: senha,
                cursorRadius: Radius.circular(10),
                obscureText: true,
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
                  labelText: 'Password',
                )),
            SizedBox(
              height: 40,
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: login,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Entrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPage()),
          );
        },
        tooltip: 'Increment',
        label: Text(
          'Cadastre-se',
        ),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
