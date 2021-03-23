import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teste_flutter/pages/detalheVideo.page.dart';
import 'package:teste_flutter/pages/admin.page.dart';

class VerVideosAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Videos(),
    );
  }
}

class Videos extends StatelessWidget {
  final vd = FirebaseFirestore.instance.collection('videos');

  Future<QuerySnapshot> querySnapshot;

  Future<QuerySnapshot> viewVideo() async {
    // Call the user's CollectionReference to add a new user
    return await vd.get();
  }

  @override
  Widget build(BuildContext context) {

    void proximaTela(id) async {
      String data, nome, url;
      String iid = id.toString();
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(iid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data()['data'].toString();
          nome = documentSnapshot.data()['nome'].toString();
          url = documentSnapshot.data()['url'].toString();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetalheVideo(iid, url, data, nome)));
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
              future: viewVideo(),
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
                                            .data()['data'])
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
                            leading: ButtonTheme(
                              buttonColor: Colors.white,
                              child: RaisedButton(
                                onPressed: () {
                                  proximaTela(querySnapshot.data?.docs[index].id);
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
