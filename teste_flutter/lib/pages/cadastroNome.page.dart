import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/login.page.dart';
import 'package:url_launcher/url_launcher.dart';

class CadastroCompletoPage extends StatelessWidget {
  String usuario, nome;
  var link;

  CadastroCompletoPage(this.usuario, this.nome, this.link);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Name(usuario, nome, link),
    );
  }
}

class Name extends StatelessWidget {
  String usuario, nome;
  var link;

  Name(this.usuario, this.nome, this.link);
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController telefone = TextEditingController();
    TextEditingController senha = TextEditingController();
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    void tela() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    Future<void> addUser() async {
      // Call the user's CollectionReference to add a new user
      if (senha.text.length > 5) {
        users
            .doc(usuario)
            .set({
              'nome': nome,
              'senha': senha.text,
              'user': usuario,
              'email': email.text,
              'telefone': telefone.text
            })
            .then((value) => tela())
            .catchError((error) => print("Failed to add user: $error"));
      }
    }

    abrirUrl() async {
      FirebaseFirestore.instance
          .collection('Link')
          .doc('1')
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          String link = await documentSnapshot.data()['link'];
          if (await canLaunch(link)) {
            await launch(link);
          } else {
            throw 'Could not launch $link';
          }
        } else {
          print("Failed to add user:");
        }
      });
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 110,
              height: 110,
              child: Image.asset('Images/logo.png',),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
                enabled: false,
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
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                enabled: false,
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
                )),
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
                )),
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
                )),
            SizedBox(
              height: 20,
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
                )),
            SizedBox(
              height: 20,
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
        onPressed: abrirUrl,
        tooltip: 'Increment',
        label: Icon( Icons.chat_bubble_outline_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
