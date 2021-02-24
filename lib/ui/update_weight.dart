import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateWeight extends StatefulWidget {
  final String docid;
  UpdateWeight({Key key , this.docid}) : super(key: key);

  @override
  _UpdateWeightState createState() => _UpdateWeightState();
}

class _UpdateWeightState extends State<UpdateWeight> {
  TextEditingController _weightController = TextEditingController();

  addWeight(double weight) {
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("Records")
          .doc(widget.docid)
          .update({"Weight": weight}).then(
              (value) => print("Updated Weight"));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.docid}"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: "Enter new weight",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.lightBlue,
                ),
                child: MaterialButton(
                  onPressed: () {
                    addWeight(double.parse(_weightController.text.toString()));
                    _weightController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Update Weight"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _weightController.dispose();
  }
}
