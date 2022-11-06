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
// List<DataRow> showCustomerInfo() {
//     List<DataRow> datarow = [];
//     userId!.docs.forEach((element) {
//       datarow.add(
//         DataRow(
//           cells: <DataCell>[
//             DataCell(
//               Text(
//                 element.get("name"),
//               )
//             ),
//             DataCell(
//               Text(
//                 element.get("uid"),
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//     return datarow;
//   }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (user != null){
    Text(user!.get('name'),style: TextStyle(fontSize: 24),);
    return SizedBox(child: Text("hi"));
          // width: double.infinity,
          // child: DataTable(
          //   columns: const <DataColumn>[
          //     DataColumn(
          //       label: Text(
          //         'Address ID',
          //         style: TextStyle(
          //             fontSize: 30,
          //             fontStyle: FontStyle.italic,
          //             color: Colors.white),
          //       ),
          //     ),
          //     DataColumn(
          //       label: Text(
          //         'Status',
          //         style: TextStyle(
          //             fontSize: 30,
          //             fontStyle: FontStyle.italic,
          //             color: Colors.white),
          //       ),
          //     ),
          //     DataColumn(
          //       label: Text(
          //         'orderBy',
          //         style: TextStyle(
          //             fontSize: 30,
          //             fontStyle: FontStyle.italic,
          //             color: Colors.white),
          //       ),
          //     ),
          //     DataColumn(
          //       label: Text(
          //         'orderID',
          //         style: TextStyle(
          //             fontSize: 30,
          //             fontStyle: FontStyle.italic,
          //             color: Colors.white),
          //       ),
          //     ),
          //   ],
          //   //rows: showCustomerInfo(),
          // ));
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
