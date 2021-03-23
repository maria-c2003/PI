import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/cadastroNome.page.dart';
import 'package:url_launcher/url_launcher.dart';

class CadastroPage extends StatelessWidget {
  var link;
  CadastroPage(this.link);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Cadastro(link),
    );
  }
}

class Cadastro extends StatelessWidget {
  var link;
  Cadastro(this.link);

  @override
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    Future<void> _showMyDialog(String text) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alerta!', textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text, textAlign: TextAlign.center),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> nextStep() {
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
          if (passFire == "aa") {
            nome = documentSnapshot.data()['nome'];
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CadastroCompletoPage(usuario, nome, link)));
          } else if (passFire != null) {
            print('senha certa');
            _showMyDialog("Usuário ja cadastrado");
          }
        } else {
          _showMyDialog("Usuário sem cadastro, falar com o administrador");
        }
      });
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
        }
      });
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 270, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 110,
              height: 110,
              child: Image.asset('Images/logo.png',),
            ),
            SizedBox(
              height: 40,
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
                  labelText: 'Informe o usuário',
                )),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: nextStep,
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
