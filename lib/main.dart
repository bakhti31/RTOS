// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a purple toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
// //         // This works for code too, not just values: Most code changes can be
// //         // tested with just a hot reload.
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.

// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   int _counter = 0;

// //   void _incrementCounter() {
// //     setState(() {
// //       // This call to setState tells the Flutter framework that something has
// //       // changed in this State, which causes it to rerun the build method below
// //       // so that the display can reflect the updated values. If we changed
// //       // _counter without calling setState(), then the build method would not be
// //       // called again, and so nothing would appear to happen.
// //       _counter++;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // TRY THIS: Try changing the color here to a specific color (to
// //         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// //         // change color while the other colors stay the same.
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: Column(
// //           // Column is also a layout widget. It takes a list of children and
// //           // arranges them vertically. By default, it sizes itself to fit its
// //           // children horizontally, and tries to be as tall as its parent.
// //           //
// //           // Column has various properties to control how it sizes itself and
// //           // how it positions its children. Here we use mainAxisAlignment to
// //           // center the children vertically; the main axis here is the vertical
// //           // axis because Columns are vertical (the cross axis would be
// //           // horizontal).
// //           //
// //           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// //           // action in the IDE, or press "p" in the console), to see the
// //           // wireframe for each widget.
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headlineMedium,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }
// // Default

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Equipment Management',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: EquipmentList(),
//     );
//   }
// }

// class EquipmentList extends StatefulWidget {
//   @override
//   _EquipmentListState createState() => _EquipmentListState();
// }

// class _EquipmentListState extends State<EquipmentList> {
//   List<dynamic> _equipmentList = [];
//   String URI = 'http://192.168.1.250/rtos/api.php';
//   @override
//   void initState() {
//     super.initState();
//     _getEquipmentList();
//   }

//   Future<void> _getEquipmentList() async {
//     final response = await http.get(Uri.parse(URI + "?equipment=1"));
//     if (response.statusCode == 200) {
//       setState(() {
//         _equipmentList = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load equipment');
//     }
//   }

//   Future<void> _addEquipment() async {
//     final response = await http.post(
//       Uri.parse(URI + "?equipment=1"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'equipment_name': 'New Equipment',
//         'equipment_type': 'Type',
//         'serial_number': 'SN123',
//         'location': 'Location'
//       }),
//     );
//     debugPrint(response.body);
//     if (response.statusCode == 200) {
//       // Refresh equipment list after adding new equipment
//       _getEquipmentList();
//     } else {
//       throw Exception('Failed to add equipment');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Equipment List'),
//       ),
//       body: ListView.builder(
//         itemCount: _equipmentList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_equipmentList[index]['equipment_name']),
//             subtitle: Text(_equipmentList[index]['location']),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addEquipment,
//         tooltip: 'Add Equipment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// Version 2
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Equipment Management',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: EquipmentList(),
//     );
//   }
// }

// class EquipmentList extends StatefulWidget {
//   @override
//   _EquipmentListState createState() => _EquipmentListState();
// }

// class _EquipmentListState extends State<EquipmentList> {
//   List<dynamic> _equipmentList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getEquipmentList();
//   }

//   Future<void> _getEquipmentList() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.1.250/rtos/api.php?equipment=1'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _equipmentList = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load equipment');
//     }
//   }

//   Future<void> _addEquipment(BuildContext context) async {
//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController typeController = TextEditingController();
//     final TextEditingController serialNumberController =
//         TextEditingController();
//     final TextEditingController locationController = TextEditingController();

//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Equipment'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                 ),
//                 TextFormField(
//                   controller: typeController,
//                   decoration: InputDecoration(labelText: 'Type'),
//                 ),
//                 TextFormField(
//                   controller: serialNumberController,
//                   decoration: InputDecoration(labelText: 'Serial Number'),
//                 ),
//                 TextFormField(
//                   controller: locationController,
//                   decoration: InputDecoration(labelText: 'Location'),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final response = await http.post(
//                   Uri.parse('http://192.168.1.250/rtos/api.php?equipment=1'),
//                   headers: <String, String>{
//                     'Content-Type': 'application/json; charset=UTF-8',
//                   },
//                   body: jsonEncode(<String, String>{
//                     'equipment_name': nameController.text,
//                     'equipment_type': typeController.text,
//                     'serial_number': serialNumberController.text,
//                     'location': locationController.text,
//                   }),
//                 );

//                 if (response.statusCode == 200) {
//                   // Refresh equipment list after adding new equipment
//                   _getEquipmentList();
//                   Navigator.of(context).pop();
//                 } else {
//                   throw Exception('Failed to add equipment');
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Equipment List'),
//       ),
//       body: ListView.builder(
//         itemCount: _equipmentList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_equipmentList[index]['equipment_name']),
//             subtitle: Text(_equipmentList[index]['location']),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _addEquipment(context),
//         tooltip: 'Add Equipment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// Adding details

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Equipment Management',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Equipment Management'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Equipment'),
//               Tab(text: 'Spare Parts'),
//               Tab(text: 'Monitoring Condition'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             EquipmentList(),
//             SparePartsList(),
//             MonitoringConditionList(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EquipmentList extends StatefulWidget {
//   @override
//   _EquipmentListState createState() => _EquipmentListState();
// }

// class _EquipmentListState extends State<EquipmentList> {
//   List<dynamic> _equipmentList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getEquipmentList();
//   }

//   Future<void> _getEquipmentList() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.1.250/rtos/api.php?equipment=1'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _equipmentList = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load equipment');
//     }
//   }

//   // Tambahkan fungsi tambahan seperti _addEquipment() di sini

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _equipmentList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(_equipmentList[index]['equipment_name']),
//           subtitle: Text(_equipmentList[index]['location']),
//         );
//       },
//     );
//   }
// }

// class SparePartsList extends StatefulWidget {
//   @override
//   _SparePartsListState createState() => _SparePartsListState();
// }

// class _SparePartsListState extends State<SparePartsList> {
//   List<dynamic> _sparePartsList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getSparePartsList();
//   }

//   Future<void> _getSparePartsList() async {
//     final response = await http
//         .get(Uri.parse('http://192.168.1.250/rtos/api.php?spareparts=1'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _sparePartsList = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load spare parts');
//     }
//   }

//   // Tambahkan fungsi tambahan seperti _addSparePart() di sini

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _sparePartsList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(_sparePartsList[index]['part_name']),
//           subtitle: Text(_sparePartsList[index]['location']),
//         );
//       },
//     );
//   }
// }

// class MonitoringConditionList extends StatefulWidget {
//   @override
//   _MonitoringConditionListState createState() =>
//       _MonitoringConditionListState();
// }

// class _MonitoringConditionListState extends State<MonitoringConditionList> {
//   List<dynamic> _monitoringConditionList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getMonitoringConditionList();
//   }

//   Future<void> _getMonitoringConditionList() async {
//     final response = await http.get(
//         Uri.parse('http://192.168.1.250/rtos/api.php?monitoringcondition=1'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _monitoringConditionList = jsonDecode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load monitoring condition');
//     }
//   }

//   // Tambahkan fungsi tambahan seperti _addMonitoringCondition() di sini

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _monitoringConditionList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(
//               'Equipment ID: ${_monitoringConditionList[index]['equipment_id']}'),
//           subtitle: Text(
//               'Timestamp: ${_monitoringConditionList[index]['timestamp']}'),
//         );
//       },
//     );
//   }
// }
/// Another details
///
///
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparepart Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SparepartList(),
    );
  }
}

class SparepartList extends StatefulWidget {
  @override
  _SparepartListState createState() => _SparepartListState();
}

class _SparepartListState extends State<SparepartList> {
  List<dynamic> _sparepartList = [];

  @override
  void initState() {
    super.initState();
    _getSparepartList();
  }

  Future<void> _getSparepartList() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.250/rtos/api.php?sparepart=1'));
    if (response.statusCode == 200) {
      setState(() {
        _sparepartList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load sparepart');
    }
  }

  Future<void> _addSparepart(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Sparepart'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(labelText: 'Number'),
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                ),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('http://192.168.1.250/rtos/api.php?sparepart=1'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'part_name': nameController.text,
                    'part_number': numberController.text,
                    'quantity_available': quantityController.text,
                    'location': locationController.text,
                  }),
                );

                if (response.statusCode == 200) {
                  // Refresh sparepart list after adding new sparepart
                  _getSparepartList();
                  Navigator.of(context).pop();
                } else {
                  throw Exception('Failed to add sparepart');
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sparepart List'),
      ),
      body: ListView.builder(
        itemCount: _sparepartList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_sparepartList[index]['part_name']),
            subtitle: Text(_sparepartList[index]['location']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSparepart(context),
        tooltip: 'Add Sparepart',
        child: Icon(Icons.add),
      ),
    );
  }
}
