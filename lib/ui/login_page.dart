import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wealthy/ui/home_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loginStatus;

  Future<bool> anonSignIn() async {
    try {
      await _auth.signInAnonymously();
      FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser.uid).set({}).then((value) => print("added user"));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16.0),
      alignment: Alignment.center,
      child: RaisedButton(
          color: Colors.greenAccent[200],
          onPressed: () async {
            _loginStatus = await anonSignIn();
            if (_loginStatus) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ),
              );
            } else {
              print("Error cannot log in");
            }
          },
          child: Text("Continue as guest")),
    );
  }
}
