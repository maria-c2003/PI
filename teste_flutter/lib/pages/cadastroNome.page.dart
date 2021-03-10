import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/cadastroNome.page.dart';
import 'package:teste_flutter/pages/login.page.dart';


class CadastroCompletoPage extends StatelessWidget {
  String usuario, nome;

  CadastroCompletoPage(this.usuario, this.nome);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Name(usuario, nome),
    );
  }
}

class Name extends StatelessWidget {
  String usuario, nome;

  Name(this.usuario, this.nome);
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController telefone = TextEditingController();
    TextEditingController senha = TextEditingController();
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      if (senha.text.length > 5) {
        users
            .doc(usuario)
            .set({
          'nome': nome,
          'senha': senha,
          'user': usuario,
          'email': email,
          'telefone': telefone
        })
            .then((value) => MaterialPageRoute(builder: (context) => LoginPage()))
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
                autofocus: false,
                readOnly: true,
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
                  labelText: usuario,
                )
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                autofocus: false,
                readOnly: true,
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
                  labelText: nome,
                )
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: email,
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
                  labelText: "Digite seu e-mail",
                )
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: telefone,
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
                  labelText: "Digite seu telefone",
                )
            ),
            TextField(
                controller: senha,
                autofocus: false,
                readOnly: false,
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
                  labelText: "Digite sua senha",
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
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Increment',
        label: Text(
          'Cadastre-se',
        ),
        backgroundColor: Colors.grey,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}