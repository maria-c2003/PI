import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:teste_flutter/pages/aluno.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';
import 'package:teste_flutter/pages/cadastro.page.dart';
import 'package:teste_flutter/pages/loginResetSenha.page.dart';
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

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alerta!', textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Usuário ou senha incorretos',
                      textAlign: TextAlign.center),
                  Text(
                      'Caso não possua usuário, fale com o administrador ou cadastre-se',
                      textAlign: TextAlign.center),
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

    Future<void> login() async {
      String nome = user.text;
      String pass = senha.text;
      String passFire;
      FirebaseFirestore.instance
          .collection('Admin')
          .doc(nome)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          passFire = documentSnapshot.data()['senha'];
          print('Document data: ${passFire}');
          if (nome == 'admin' && pass == 'admin2021') {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPage()));
          } else {
            _showMyDialog();
          }
        } else if (pass.length > 2) {
          FirebaseFirestore.instance
              .collection('User')
              .doc(nome)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              passFire = documentSnapshot.data()['senha'];
              print('Document data: ${passFire}');
              if (passFire == pass) {
                print('senha certa');
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AlunoPage()));
              } else {
                _showMyDialog();
              }
            }
          });
        } else {
          _showMyDialog();
        }
      });
    }

    Future<void> getLink() async {
      FirebaseFirestore.instance
          .collection('Link')
          .doc('1')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          String link = documentSnapshot.data()['link'];
        }
      });
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 260, left: 40, right: 40),
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
                  labelText: 'Usuário',
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
                  labelText: 'Senha',
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
            SizedBox(
              height: 8,
            ),
            TextButton(
              child: Text('Esqueci minha senha'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EsqueciSenha()));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var link = getLink();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPage(link)),
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
