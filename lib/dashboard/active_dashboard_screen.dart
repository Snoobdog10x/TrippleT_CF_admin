import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:pie_chart/pie_chart.dart';

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
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  final colorList = <Color>[
    Colors.greenAccent,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
  ];
  int height = 160;
  int weight = 60;
  int age = 25;
  String bmi = '';
  int count_orders = 0;
  int count_packaging = 0;
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
    getCountPackaging().then(
      (value) {
        setState(() {
          count_packaging = value;
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
    const defaultPadding = 16.0;
    const color_card = Colors.grey;
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
      body: Container(
        child: ListView(
          children: [
            Row(
              children: [
                _container_all_orders(count_orders),
                _container_packaging(count_packaging),
                _container_delivered(count_delivered),
                _container_completed(count_completed),
              ],
            ),
            Row(
              children: [
                _container_piechart_orders_status(dataMap, colorList),
                _container_packaging(count_packaging),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _container_all_orders(int count_orders) {
  return Expanded(
    child: Container(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 20.0,
        child: Container(
          color: Colors.blueGrey.withOpacity(0.8),
          width: 250,
          height: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.view_timeline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    '   All Orders',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
                  Icon(Icons.more_vert),
                ],
              ),
              const Divider(),
              Text(
                count_orders.toString(),
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

Future<int> getCountAllOrders() async {
  QuerySnapshot ordersCollection =
      await FirebaseFirestore.instance.collection('orders').get();
  int ordersCount = ordersCollection.size;
  return ordersCount;
}

Widget _container_packaging(int count_packaging) {
  return Expanded(
    child: Container(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 20.0,
        child: Container(
          color: Colors.blueGrey.withOpacity(0.8),
          width: 250,
          height: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.view_timeline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    '   Packaging',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
                  Icon(Icons.more_vert),
                ],
              ),
              const Divider(),
              Text(
                count_packaging.toString(),
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

Future<int> getCountPackaging() async {
  QuerySnapshot packagingCollection = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "packaging")
      .get();
  int packagingCount = packagingCollection.size;
  return packagingCount;
}

Widget _container_delivered(int count_delivered) {
  return Expanded(
    child: Container(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 20.0,
        child: Container(
          color: Colors.blueGrey.withOpacity(0.8),
          width: 250,
          height: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.view_timeline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    '   Delivered',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
                  Icon(Icons.more_vert),
                ],
              ),
              const Divider(),
              Text(
                count_delivered.toString(),
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

Future<int> getCountDelivered() async {
  QuerySnapshot deliveredCollection = await FirebaseFirestore.instance
      .collection('orders')
      .where("status", isEqualTo: "delivered")
      .get();
  int deliveredCount = deliveredCollection.size;
  return deliveredCount;
}

Widget _container_completed(int count_completed) {
  return Expanded(
    child: Container(
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 20.0,
        child: Container(
          color: Colors.blueGrey.withOpacity(0.8),
          width: 250,
          height: 180,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.view_timeline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    '   Completed',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  )),
                  Icon(Icons.more_vert),
                ],
              ),
              const Divider(),
              Text(
                count_completed.toString(),
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
      .where("status", isEqualTo: "completed")
      .get();
  int completedCount = completedCollection.size;
  return completedCount;
}

Widget _container_piechart_orders_status(
    Map<String, double> dataMap, colorList) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: PieChart(
        dataMap: dataMap,
        chartType: ChartType.ring,
        baseChartColor: Colors.grey[300]!,
        colorList: colorList,
      ),
    ),
  );
}
