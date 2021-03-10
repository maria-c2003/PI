import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 300, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              ButtonTheme(
                height: 45,
                child: RaisedButton(
                  onPressed: () => {
                    print("login"),
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  child: Text(
                    "Ver vídeos disponiveis",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.pinkAccent[50],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
