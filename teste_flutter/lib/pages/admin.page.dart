import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/newUser.page.dart';
import 'package:teste_flutter/pages/verVideos.page.dart';
import 'package:teste_flutter/pages/newVideo.page.dart';
import 'package:teste_flutter/pages/verUsers.page.dart';
import 'package:teste_flutter/pages/adminLink.page.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Botoes(),
    );
  }
}

class Botoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 300, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerVideosAdmin()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Ver vídeos disponíveis",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerUsersAdmin()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Ver usuários cadastrados",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NovoVideo()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Adicionar novo vídeo",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
            ButtonTheme(
              height: 45,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NovoUser()),
                  );
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)),
                child: Text(
                  "Adicionar novo usuário",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.pinkAccent[50],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Link()),
          );
        },
        child: const Icon(
          IconData(58274, fontFamily: 'MaterialIcons'),
          color: Colors.white,
        ),
        hoverColor: Colors.white,
        backgroundColor: Colors.grey,
      ),
    );
  }
}
