import 'dart:collection';
import 'dart:core';
import 'dart:math';

import 'package:bringapp_admin_web_portal/order/detailOrderOnClick.dart';
import 'package:bringapp_admin_web_portal/order/userGetData.dart';
import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'orderProgress.dart';

class OrderdetailScreen extends StatefulWidget {
  const OrderdetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderdetailScreen> createState() => _OrderdetailScreenState();
}

class _OrderdetailScreenState extends State<OrderdetailScreen> {
  QuerySnapshot? allorders;
  bool is_update_status = false;
  List<QueryDocumentSnapshot<Object?>> test11 = [];
  openorderdetail(BuildContext context) {}

  changestatusorderdetail(current_status, orderDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Change status",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
          ),
          content: Text(
            "Do you want to change this status",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "change" ? " " : "Cooking");
                Map<String, dynamic> orderDataMap = {
                  //change status to not approved
                  "status": status,
                };

                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderDocumentID)
                    .update(orderDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "Status changed",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                      .collection("orders")
                      .get()
                      .then((allActiveOrders) {
                    fetch_data();
                    setState(() {
                      allorders = allActiveOrders;
                    });
                  });
                });
              },
              child: const Text("Cooking"),
            ),
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "change" ? "" : "Ordering");
                Map<String, dynamic> orderDataMap = {
                  //change status to not approved
                  "status": status,
                };

                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderDocumentID)
                    .update(orderDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "User has been",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                      .collection("orders")
                      .get()
                      .then((allActiveOrders) {
                    setState(() {
                      allorders = allActiveOrders;
                    });
                  });
                });
              },
              child: const Text("Ordering"),
            ),
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "change" ? " " : "Shipping");
                Map<String, dynamic> orderDataMap = {
                  //change status to not approved
                  "status": status,
                };

                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderDocumentID)
                    .update(orderDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "User has been",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                      .collection("orders")
                      .get()
                      .then((allActiveOrders) {
                    setState(() {
                      allorders = allActiveOrders;
                    });
                  });
                });
              },
              child: const Text("Shipping"),
            ),
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "change" ? "" : "Delivered");
                Map<String, dynamic> orderDataMap = {
                  //change status to not approved
                  "status": status,
                };

                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderDocumentID)
                    .update(orderDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "User has been",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                      .collection("orders")
                      .get()
                      .then((allActiveOrders) {
                    setState(() {
                      allorders = allActiveOrders;
                    });
                  });
                });
              },
              child: const Text("Delivered"),
            ),
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "change" ? "" : "cancel");
                Map<String, dynamic> orderDataMap = {
                  //change status to not approved
                  "status": status,
                };

                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderDocumentID)
                    .update(orderDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "User has been",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance
                      .collection("orders")
                      .get()
                      .then((allActiveOrders) {
                    setState(() {
                      allorders = allActiveOrders;
                    });
                  });
                });
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("orders")
        .get()
        .then((allActiveOrders) {
      setState(() {
        allorders = allActiveOrders;
      });
    });
  }

  getCurrentStepIndex(currentStepText) {
    if (currentStepText == "Ordering") return 0;
    if (currentStepText == "Cooking") return 1;
    if (currentStepText == "Shipping") return 2;
    if (currentStepText == "Delivered") return 3;
    if (currentStepText == "Cancel") return 4;
  }

  showDetailDialog(
      String orderId, String status, String userId, String addressId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Builder(builder: (context) {
          var height = MediaQuery.of(context).size.height * 0.8;
          var width = MediaQuery.of(context).size.width * 0.9;
          int currentStep = getCurrentStepIndex(status);
          return SizedBox(
            height: height,
            width: width,
            child: ListView(
              children: [
                AppBar(
                  leading: CloseButton(),
                  title: Text("Order ID:" + orderId),
                ),
                userGetData(userId, addressId),
                StepperDemo(currentStep),
                detailOrderOnClick(orderId),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<DataRow> fetch_data() {
    List<DataRow> datarow = [];
    allorders!.docs.forEach(
      (element) {
        datarow.add(
          DataRow(
            onLongPress: () {
              showDetailDialog(element.get("orderId"), element.get("status"),
                  element.get("orderBy"), element.get("addressID"));
            },
            cells: <DataCell>[
              DataCell(
                Text(
                  element.get("orderId"),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  element.get("addressID"),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataCell(
                TextButton(
                  child: Text(element.get("status")),
                  onPressed: () {
                    changestatusorderdetail(element.get("status"), element.id);
                  },
                ),
              ),
              DataCell(
                Text(
                  element.get("orderBy"),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
    return datarow;
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    //return Colors.green; // Use the default value.
    return Colors.transparent;
  }

  customer_infor() {
    return Expanded(
      child: Column(
        children: <Widget>[
          ListTile(
            isThreeLine: true,
            //leading: Icon(Icons.event_note),
            title: Text('Address Confirming'),
            // subtitle: Text('Title2'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('name :'),
                Text('email :'),
                Text('address :'),
                Text('and so on :')
              ],
            ),
          )
        ],
      ),
    );
  }

  container_packaging(String orderId, String userId, String addressId) {
    return Expanded(
      child: Container(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 20.0,
          child: Container(
            color: Colors.blueGrey.withOpacity(0.8),
            width: 250,
            height: 480,
            padding: const EdgeInsets.all(20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order List',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.purple,
                      ),
                    ),

                    //Icon(Icons.more_vert),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: detailOrderOnClick(orderId),
                ),
                //Text('chao', textAlign: TextAlign.left,),
                //container_status(),
                // Row(
                //   children: [
                //     //container_status(),
                //     container_status(),
                //   ],
                //   //Icon(Icons.more_vert),
                // ),
                // Row(
                //   children: [
                //     //container_status(),
                //     // container_status(),
                //     //Icon(Icons.more_vert),
                //   ],
                // ),
                // Row(
                //   children: [
                //     // container_status(),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (allorders != null) {
      return SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Address ID',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'orderBy',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'orderID',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
            ],
            rows: fetch_data(),
          ));
    } else {
      return Scaffold(
        backgroundColor: const Color(0xff1b232A),
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white,
            size: 200,
          ),
        ),
      );
    }
  }
}
