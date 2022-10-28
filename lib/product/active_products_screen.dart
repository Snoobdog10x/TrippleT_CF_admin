import 'dart:math';

import 'package:bringapp_admin_web_portal/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActiveProductScreen extends StatefulWidget {
  const ActiveProductScreen({Key? key}) : super(key: key);

  @override
  State<ActiveProductScreen> createState() => _ActiveProductScreenState();
}

class _ActiveProductScreenState extends State<ActiveProductScreen> {
  QuerySnapshot? allproducts;
  TextEditingController itemIdController = TextEditingController();
  TextEditingController itemImageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CollectionReference items = FirebaseFirestore.instance.collection('items');
  // bool is_update_status = false;
  // displayDialogBoxForBlockingAccount(current_status, userDocumentID) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           "Block Account",
  //           style: GoogleFonts.lato(
  //             textStyle: const TextStyle(
  //               fontSize: 25,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //               letterSpacing: 2,
  //             ),
  //           ),
  //         ),
  //         content: Text(
  //           "Do you want to" +
  //               (current_status == "approved" ? " block " : " unblock ") +
  //               "this account ?",
  //           style: GoogleFonts.lato(
  //             textStyle: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.normal,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text("No"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               String status = (current_status == "approved"
  //                   ? "not approved"
  //                   : "approved");
  //               Map<String, dynamic> userDataMap = {
  //                 //change status to not approved
  //                 "status": status,
  //               };

  //               FirebaseFirestore.instance
  //                   .collection("users")
  //                   .doc(userDocumentID)
  //                   .update(userDataMap)
  //                   .then((value) {
  //                 SnackBar snackBar = SnackBar(
  //                   content: Text(
  //                     "User has been" +
  //                         (current_status == "approved"
  //                             ? " block"
  //                             : " unblock"),
  //                     style: TextStyle(
  //                       fontSize: 36,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   backgroundColor: Colors.amber,
  //                   duration: Duration(seconds: 2),
  //                 );
  //                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //                 Navigator.of(context).pop();
  //                 FirebaseFirestore.instance
  //                     .collection("users")
  //                     .get()
  //                     .then((allActiveProducts) {
  //                   setState(() {
  //                     allproducts = allActiveProducts;
  //                   });
  //                 });
  //               });
  //             },
  //             child: const Text("Yes"),
  //           ),
  //         ],
  // //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("items")
        .get()
        .then((allActiveProducts) {
      setState(() {
        allproducts = allActiveProducts;
      });
    });
  }

  List<DataRow> fetch_data() {
    List<DataRow> datarow = [];
    allproducts!.docs.forEach(
      (element) {
        datarow.add(
          DataRow(
            cells: <DataCell>[
              DataCell(
                Expanded(
                  child: Text(
                    element.get("itemID"),
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                ImageNetwork(
                  image: element.get("thumbnailUrl"),
                  // imageCache: CachedNetworkImageProvider(imageUrl),
                  height: 50,
                  width: 50,
                  duration: 1500,
                  curve: Curves.easeIn,
                  onPointer: false,
                  debugPrint: false,
                  fullScreen: false,
                  fitAndroidIos: BoxFit.fill,
                  fitWeb: BoxFitWeb.fill,
                  borderRadius: BorderRadius.circular(70),
                  onLoading: const CircularProgressIndicator(
                    color: Colors.indigoAccent,
                  ),
                  onError: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
              DataCell(
                Expanded(
                  child: Text(
                    element.get("title"),
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
              DataCell(
                Expanded(
                  child: Text(
                    element.get("price"),
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return datarow;
  }

  @override
  Widget build(BuildContext context) {
    if (allproducts != null) {
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
            "Product Management",
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                showDialogWithFields();
              },
              child: Text('Add Product'),
            ),
          ],
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Items ID',
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
                    'Items Image',
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
                    'Name',
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
                    'Price',
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
            rows: fetch_data(),
          ),
        ),
      );
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

  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            "Add New Product",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: itemIdController,
                    decoration: InputDecoration(
                      labelText: 'Items ID',
                      icon: Icon(Icons.confirmation_number),
                    ),
                  ),
                  TextFormField(
                    controller: itemImageController,
                    decoration: InputDecoration(
                      labelText: 'Items Image',
                      icon: Icon(Icons.image),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.drive_file_rename_outline),
                    ),
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      icon: Icon(Icons.payments),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                saveInfo(itemIdController.text, itemImageController.text,
                    nameController.text, priceController.text);
                Navigator.pop(context);
              },
              child: Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  clearMenuUploadFrom() {
    setState(() {
      itemIdController.clear();
      itemImageController.clear();
      nameController.clear();
      priceController.clear();
    });
  }

  saveInfo(String itemId, String thumbnailUrl, String title, String price) {
    final ref = FirebaseFirestore.instance
        //under sellers collection
        .collection("items");

    ref.doc().set(
      {
        "catalogId": '',
        "itemId": itemId,
        "price": price,
        "shortInfo": '',
        "status": '',
        "thumbnailUrl": thumbnailUrl,
        "title": title
      },
    ).then(
      (value) {
        clearMenuUploadFrom();
      },
    );
  }

  // Future<void> addItem(
  //     String itemId, String thumbnailUrl, String title, String price) {
  //   // Call the user's CollectionReference to add a new items
  //   return items.add({
  //     'catalogId': '',
  //     'itemId': itemId,
  //     'price': price,
  //     'shortInfo': '',
  //     'status': '',
  //     'thumbnailUrl': thumbnailUrl,
  //     'title': title
  //   });
  // }
}
