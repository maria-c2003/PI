import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/detalheUser.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';

class VerUsersAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Usersss(),
    );
  }
}

class Usersss extends StatelessWidget {
  final vd = FirebaseFirestore.instance.collection('User');

  Future<QuerySnapshot> querySnapshot;

  Future<QuerySnapshot> viewUser() async {
    // Call the user's CollectionReference to add a new user
    return await vd.get();
  }

  @override
  Widget build(BuildContext context) {
    void tela() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminPage()));
    }

    void proxTela(user, index, index2) async {
      String usuario = user.toString();
      String senha, nome, email, telefone;
      print('Index:: ${index}');
      print('Index2: ${index2}');
      await FirebaseFirestore.instance
          .collection('User')
          .doc(usuario)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          senha = documentSnapshot.data()['senha'].toString();
          nome = documentSnapshot.data()['nome'].toString();
          email = documentSnapshot.data()['email'].toString();
          telefone = documentSnapshot.data()['telefone'].toString();
          print('Document data: ${usuario}');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetalheUser(usuario, email, telefone, senha, nome, documentSnapshot)));
        }
      });
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: viewUser(),
              builder: (context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (querySnapshot.connectionState == ConnectionState.waiting) {
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.data?.docs.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 70,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Card(
                          child: ListTile(
                            subtitle: Row(
                              children: [
                                Text(
                                    (querySnapshot.data?.docs[index]
                                            .data()['user'])
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                        (querySnapshot.data?.docs[index]
                                            .data()['nome']),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            leading:
                            ButtonTheme(
                              buttonColor: Colors.white,
                              child: RaisedButton(
                                onPressed: () {
                                  proxTela(querySnapshot.data?.docs[index]
                                      .data()['user'], index, querySnapshot.data?.docs[index].id);
                                },
                                color: Colors.white,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(100)),
                                child: Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
