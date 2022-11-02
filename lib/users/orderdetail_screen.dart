import 'dart:collection';
import 'dart:math';

import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderdetailScreen extends StatefulWidget {
  const OrderdetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderdetailScreen> createState() => _OrderdetailScreenState();
}

class _OrderdetailScreenState extends State<OrderdetailScreen> {
  QuerySnapshot? allorders;
  bool is_update_status = false;
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
                String status = (current_status == "change" ? "" : "canceling");
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
              child: const Text("Canceling"),
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

  List<DataRow> fetch_data() {
    List<DataRow> datarow = [];
    allorders!.docs.forEach(
      (element) {
        datarow.add(
          DataRow(
            onLongPress: () {
              Map<String, dynamic> a = element.get("items");
              FirebaseFirestore.instance
                  .collection("items")
                  .where(FieldPath.documentId, whereIn: a.keys.toList())
                  .get()
                  .then((a) {});
              QuerySnapshot? itemsbyorder;
              FirebaseFirestore.instance
                  .collection("items")
                  .where(FieldPath.documentId, whereIn: a.keys.toList())
                  .get()
                  .then((a) {
                itemsbyorder = a;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
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
                    " ",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
            cells: <DataCell>[
              DataCell(
                Expanded(
                  child: Text(
                    element.get("addressID"),
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                Expanded(
                  child: TextButton(
                    child: Text(element.get("status")),
                    onPressed: () {
                      changestatusorderdetail(
                          element.get("status"), element.id);
                    },
                  ),
                ),
              ),
              DataCell(
                Expanded(
                  child: Text(
                    element.get("orderBy"),
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                Expanded(
                  child: Text(
                    element.get("orderId"),
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
        datarow.add(
          DataRow(
            
            cells: <DataCell>[

            ],
          ),
        );
      },
    );
    return datarow;
  }

  @override
  Widget build(BuildContext context) {
    if (allorders != null) {
      return SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Address ID',
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Status',
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'orderBy',
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'orderID',
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
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
