import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/admin.page.dart';


class Link extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Liink(),
    );
  }
}

class Liink extends StatelessWidget {
  @override
  TextEditingController link = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('User');



  @override
  Widget build(BuildContext context) {

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
                  Text(text,  textAlign: TextAlign.center),
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
      String liink = link.text;
      FirebaseFirestore.instance
          .collection('Link')
          .doc('1')
          .update({'link': liink})
          .then((value) => {
        _showMyDialog("Link atualizado com sucesso"),
        Navigator.pop(context),
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminPage()))
      })
          .catchError((error) => {
        _showMyDialog("Error")
      });
    }


    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 300, left: 40, right: 40),
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
                controller: link,
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
                  labelText: 'Informe o link',
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
                  "Atualizar Link",
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

