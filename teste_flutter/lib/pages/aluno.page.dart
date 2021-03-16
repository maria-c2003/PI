import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/verVideoUser.dart';

class AlunoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void page() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => VerVideosUser()));
    }

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 260, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 110,
                height: 110,
                child: Image.asset(
                  'Images/logo.png',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ButtonTheme(
                height: 45,
                child: RaisedButton(
                  onPressed: page,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  child: Text(
                    "Ver vídeos disponíveis",
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
