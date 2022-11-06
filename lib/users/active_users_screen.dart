import 'dart:math';

import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActiveUsersScreen extends StatefulWidget {
  const ActiveUsersScreen({Key? key}) : super(key: key);

  @override
  State<ActiveUsersScreen> createState() => _ActiveUsersScreenState();
}

class _ActiveUsersScreenState extends State<ActiveUsersScreen> {
  QuerySnapshot? allusers;
  bool is_update_status = false;
  displayDialogBoxForBlockingAccount(current_status, userDocumentID) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Block Account",
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
            "Do you want to" +
                (current_status == "approved" ? " block " : " unblock ") +
                "this account ?",
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
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                String status = (current_status == "approved"
                    ? "not approved"
                    : "approved");
                Map<String, dynamic> userDataMap = {
                  //change status to not approved
                  "status": status,
                };
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(userDocumentID)
                    .update(userDataMap)
                    .then((value) {
                  SnackBar snackBar = SnackBar(
                    content: Text(
                      "User has been" +
                          (current_status == "approved"
                              ? " block"
                              : " unblock"),
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.amber,
                    duration: Duration(seconds: 2),
                  );

                  FirebaseFirestore.instance
                      .collection("users")
                      .get()
                      .then((allActiveUsers) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                      allusers = allActiveUsers;
                    });
                  });
                });
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection("users").get().then(
      (allActiveUsers) {
        setState(
          () {
            allusers = allActiveUsers;
          },
        );
      },
    );
  }

  List<DataRow> fetch_data() {
    List<DataRow> datarow = [];
    allusers!.docs.forEach(
      (element) {
        datarow.add(
          DataRow(
            cells: <DataCell>[
              DataCell(
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: Image.network(
                    element.get("photoUrl"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              DataCell(
                Text(
                  element.get("name"),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataCell(
                Text(
                  element.get("email"),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataCell(
                TextButton(
                  child: Text(element.get("status") == "approved"
                      ? 'Block'
                      : "Unblock"),
                  onPressed: () {
                    displayDialogBoxForBlockingAccount(
                        element.get("status"), element.id);
                  },
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

  @override
  Widget build(BuildContext context) {
    if (allusers != null) {
      return Scaffold(
        backgroundColor: const Color(0xff1b232A),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1b232A),
                  Colors.white,
                ],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(6, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "User Management",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          child: DataTable(
            dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Avatar',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
              DataColumn(
                label: Text(
                  'Block | Unblock',
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
              ),
            ],
            rows: fetch_data(),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1b232A),
                  Colors.white,
                ],
                begin: FractionalOffset(0, 0),
                end: FractionalOffset(6, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "User Management",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
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
