import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/cadastroNome.page.dart';


class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Casd(),
    );
  }
}

class Casd extends StatelessWidget {
  @override
  TextEditingController user = TextEditingController();

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
      String usuario = user.text;
      String nome;
      String passFire;
      FirebaseFirestore.instance
          .collection('User')
          .doc(usuario)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          passFire = documentSnapshot.data()['senha'];
          print('Document data: ${passFire}');
          if (passFire == null) {
            nome = documentSnapshot.data()['nome'];
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => CadastroCompletoPage(usuario, nome)));
          } else if (passFire != null) {
            print('senha certa');
            //TODO aviso e abort, usuario ja cadastrado
          }
        } else {
         //TODO sem cadastro, falar com o administrador
        }
      });
    }

    ;

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
                  labelText: 'Informe o usuario',
                )),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: login,
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

