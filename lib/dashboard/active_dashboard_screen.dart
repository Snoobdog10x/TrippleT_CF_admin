// ignore_for_file: non_constant_identifier_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ActivedashboardScreen extends StatefulWidget {
  const ActivedashboardScreen({Key? key}) : super(key: key);

  @override
  State<ActivedashboardScreen> createState() => _ActivedashboardScreenState();
}

class _ActivedashboardScreenState extends State<ActivedashboardScreen> {
  QuerySnapshot? allusers;
  QuerySnapshot? allorders;
  final activeColor = Colors.white30;
  final inactiveColor = Colors.white12;
  final Map<String, double> dataMap = {
    "Ordering": 5,
    "Cooking": 3,
    "Shipping": 2,
    "Delivered": 2,
    "Cancel": 2,
  };
  List<Color> gradientList = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.brown
  ];
  int count_orders = 0;
  int count_cooking = 0;
  int count_delivered = 0;
  int count_completed = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("orders")
        .get()
        .then((allActiveOrder) {
      allorders = allActiveOrder;
    });
    FirebaseFirestore.instance.collection("users").get().then((allActiveUsers) {
      allusers = allActiveUsers;
    });
    getCountAllOrders().then(
      (value) {
        setState(() {
          count_orders = value;
        });
      },
    );
    getCountCooking().then(
      (value) {
        setState(() {
          count_cooking = value;
        });
      },
    );
    getCountDelivered().then(
      (value) {
        setState(() {
          count_delivered = value;
        });
      },
    );
    getCountCompleted().then(
      (value) {
        setState(() {
          count_completed = value;
        });
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
        title: const AutoSizeText(
          "Dashboard",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff1b232A),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                _container_all_orders(count_orders),
                _container_cooking(count_cooking),
                _container_delivered(count_delivered),
                _container_completed(count_completed),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                _container_piechart_orders_status(dataMap, gradientList),
                _container_piechart_top_seller(dataMap, gradientList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _container_all_orders(int countOrders) {
  return Expanded(
    flex: 2,
    child: Card(
      margin: const EdgeInsets.all(20),
      // elevation: 20.0,
      child: Container(
        color: Colors.blueGrey.withOpacity(0.8),
        width: 250,
        height: 180,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.view_timeline,
                  size: 30,
                  color: Colors.white,
                ),
                Expanded(
                    child: AutoSizeText(
                  'All Orders',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )),
                Icon(Icons.more_vert),
              ],
            ),
            const Divider(),
            AutoSizeText(
              countOrders.toString(),
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<int> getCountAllOrders() async {
  QuerySnapshot ordersCollection =
      await FirebaseFirestore.instance.collection('orders').get();
  int ordersCount = ordersCollection.size;
  return ordersCount;
}

Widget _container_cooking(int countCooking) {
  return Expanded(
    flex: 2,
    child: Card(
      margin: const EdgeInsets.all(20),
      // elevation: 20.0,
      child: Container(
        color: Colors.blueGrey.withOpacity(0.8),
        width: 250,
        height: 180,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.view_timeline,
                  size: 30,
                  color: Colors.white,
                ),
                Expanded(
                    child: AutoSizeText(
                  'Cooking',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )),
                Icon(Icons.more_vert),
              ],
            ),
            const Divider(),
            AutoSizeText(
              countCooking.toString(),
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<int> getCountCooking() async {
  QuerySnapshot packagingCollection = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "Cooking")
      .get();
  int packagingCount = packagingCollection.size;
  return packagingCount;
}

Widget _container_delivered(int countDelivered) {
  return Expanded(
    flex: 2,
    child: Card(
      margin: const EdgeInsets.all(20),
      // elevation: 20.0,
      child: Container(
        color: Colors.blueGrey.withOpacity(0.8),
        width: 250,
        height: 180,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.view_timeline,
                  size: 30,
                  color: Colors.white,
                ),
                Expanded(
                    child: AutoSizeText(
                  'Delivered',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )),
                Icon(Icons.more_vert),
              ],
            ),
            const Divider(),
            AutoSizeText(
              countDelivered.toString(),
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 5
                  ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<int> getCountDelivered() async {
  QuerySnapshot deliveredCollection = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "delivered")
      .get();
  int deliveredCount = deliveredCollection.size;
  return deliveredCount;
}

Widget _container_completed(int countCancel) {
  return Expanded(
    flex: 2,
    child: Container(
      child: Card(
        margin: const EdgeInsets.all(20),
        // elevation: 20.0,
        child: Container(
          color: Colors.blueGrey.withOpacity(0.8),
          width: 250,
          height: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.view_timeline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )),
                  Icon(Icons.more_vert),
                ],
              ),
              const Divider(),
              AutoSizeText(
                countCancel.toString(),
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<int> getCountCompleted() async {
  QuerySnapshot completedCollection = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "Cancel")
      .get();
  int completedCount = completedCollection.size;
  return completedCount;
}

Widget _container_piechart_orders_status(
    Map<String, double> dataMap, gradientList) {
  return Expanded(
    flex: 5,
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  'All Orders',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 9,
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              baseChartColor: Colors.grey[300]!,
              colorList: gradientList,
              emptyColorGradient: const [
                Color(0xff6c5ce7),
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _container_piechart_top_seller(
    Map<String, double> dataMap, gradientList) {
  return Expanded(
    flex: 5,
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  'Top 5 Sellers Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 9,
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              baseChartColor: Colors.grey[300]!,
              colorList: gradientList,
              emptyColorGradient: const [
                Color(0xff6c5ce7),
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
