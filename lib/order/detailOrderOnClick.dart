import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class detailOrderOnClick extends StatefulWidget {
  String? orderId;
  detailOrderOnClick(this.orderId, {super.key}) {
    this.orderId = orderId;
  }
  @override
  State<StatefulWidget> createState() => _detailOrderOnClickState(orderId);
}

class _detailOrderOnClickState extends State<detailOrderOnClick> {
  String? orderId;
  List<QueryDocumentSnapshot> allItem = [];
  _detailOrderOnClickState(this.orderId);
  List<String>? quantities;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get()
        .then((value) {
      List<dynamic> productIds = value.get("productIDs");
      List<String> ids = separateOrderItemIDs(productIds);
      List<String> quantities = separateOrderItemQuantities(productIds);
      FirebaseFirestore.instance
          .collection("items")
          .where("itemID", whereIn: ids)
          // .where("sellerUID",
          //     whereIn: (snapshot.data!.docs[index].data()!
          //         as Map<String, dynamic>)["uid"])
          // .orderBy("publishedDate", descending: true)
          .get()
          .then((value) {
        List<QueryDocumentSnapshot> temp = [];
        value.docs.forEach((element) {
          temp.add(element);
        });
        setState(() {
          allItem = temp;
          this.quantities = quantities;
        });
      });
    });
  }

  separateOrderItemIDs(orderIDs) {
    List<String> separateItemIDsList = [], defaultItemList = [];
    int i = 0;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //this format => 34567654:7
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      //to this format => 34567654
      String getItemId = (pos != -1) ? item.substring(0, pos) : item;

      separateItemIDsList.add(getItemId);
    }

    return separateItemIDsList;
  }

  separateOrderItemQuantities(orderIDs) {
    List<String> separateItemQuantityList = [];
    List<String> defaultItemList = [];
    int i = 0;

    defaultItemList = List<String>.from(orderIDs);

    for (i; i < defaultItemList.length; i++) {
      //this format => 34567654:7
      String item = defaultItemList[i].toString();

      //to this format => 7
      List<String> listItemCharacters = item.split(":").toList();

      //converting to int
      var quanNumber = int.parse(listItemCharacters[1].toString());

      separateItemQuantityList.add(quanNumber.toString());
    }

    return separateItemQuantityList;
  }

  Container itemsCard(
      String thumnailUrl, String itemName, String itemquantity) {
    return Container(
      width: 500,
      height: 70,
      child: Row(
        children: [
          ImageNetwork(
            image: thumnailUrl,
            // imageCache: CachedNetworkImageProvider(imageUrl),
            height: 65,
            width: 65,
            duration: 1500,
            // curve: Curves.easeIn,
            onPointer: true,
            debugPrint: false,
            fullScreen: false,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.cover,
            // borderRadius: BorderRadius.circular(70),
            onLoading: const CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
            onError: const Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                itemName,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
              subtitle: Text(
                "x" + itemquantity,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> showItemData() {
    List<DataRow> datarow = [];
    allItem.forEach((element) {
      datarow.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              itemsCard(
                element.get("thumbnailUrl"),
                element.get("title"),
                quantities![allItem.indexOf(element)],
              ),
            ),
            DataCell(
              Text(
                element.get("price"),
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
    datarow.add(
      DataRow(
        cells: <DataCell>[
          DataCell(
            Text('Tong tien hang'),
          ),
          DataCell(
            Text('19,000đ'),
          ),
        ],
      ),
    );
    datarow.add(
      DataRow(
        cells: <DataCell>[
          DataCell(
            Text('Tiền vận chuyển'),
          ),
          DataCell(
            Text('19,000đ'),
          ),
        ],
      ),
    );
    datarow.add(
      DataRow(
        cells: <DataCell>[
          DataCell(
            Text('Tong tien'),
          ),
          DataCell(
            Text('43,000đ'),
          ),
        ],
      ),
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
    if (!allItem.isEmpty) {
      return SizedBox(
        width: double.infinity,
        child: DataTable(
          dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Item',
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            ),
            DataColumn(
              label: Text(
                'Price',
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            ),
          ],
          rows: showItemData(),
        ),
      );
    }
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 200,
      ),
    );
  }
}
