import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/verUsers.page.dart';

class DetalheUser extends StatelessWidget {
  String usuario, nome, senha, email, telefone;
  var doc;

  DetalheUser(
      this.usuario, this.email, this.telefone, this.senha, this.nome, this.doc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: User(usuario, email, telefone, senha, nome, doc),
    );
  }
}

class User extends StatelessWidget {
  String usuario, nome, senha, email, telefone;
  var doc;

  User(
      this.usuario, this.email, this.telefone, this.senha, this.nome, this.doc);

  @override
  Widget build(BuildContext context) {
    print('Document data: ${usuario}');
    CollectionReference users = FirebaseFirestore.instance.collection('User');

    void tela() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VerUsersAdmin()));
    }

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
                  Text( text,
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

    Future<void> deleteUser() {
      CollectionReference users = FirebaseFirestore.instance.collection('User');
      return users
          .doc(usuario)
          .delete()
          .then((value) => {
        _showMyDialog("Usuário deletado com sucesso"),
        tela()
      })
          .catchError((error) => {
        _showMyDialog("Error"),
      });
    }

    Future<void> deleteMenssage() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alerta!', textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Você tem certeza que deseja excluir esse usuário?",
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteUser();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> Senha() {
      return users
          .doc(usuario)
          .update({'senha': "aa"})
          .then((value) => () {
                _showMyDialog("Senha resetada com sucesso!");
                tela();
              })
          .catchError((error) => print("Failed to update user: $error"));
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
                enabled: false,
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
                  labelText: email,
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                enabled: false,
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
                  labelText: telefone,
                )),
            SizedBox(
              height: 20,
            ),
            TextField(
                enabled: false,
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
                  labelText: senha,
                )),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: Senha,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Resetar senha",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: deleteMenssage,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Excluir usuário",
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
        label: Icon( Icons.chat_bubble_outline_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
        onPressed: () {  },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
