import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class userGetData extends StatefulWidget {
  String? userId;
  String? addressId;
  userGetData(this.userId, this.addressId, {super.key});
  @override
  State<StatefulWidget> createState() => _serGetDataState(userId, addressId);
}

class _serGetDataState extends State {
  String? userId;
  String? addressId;
  DocumentSnapshot<Map<String, dynamic>>? user;
  DocumentSnapshot<Map<String, dynamic>>? address;
  _serGetDataState(this.userId, this.addressId);
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("userAddress")
          .doc(addressId)
          .get()
          .then((value1) {
        setState(() {
          user = value;
          address = value1;
          print(address!.data().toString());
          print(user!.data().toString());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (user != null) return Text("hihi");

    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 200,
      ),
    );
  }
}
