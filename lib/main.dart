import 'package:flutter/material.dart';
import 'package:rtos/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipanagement',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}


// main






// // ignore_for_file: library_private_types_in_public_api

// // import 'dart:convert';
// import 'package:flutter/material.dart';
// import "package:rtos/monitoring.dart";
// import 'package:rtos/equipment.dart';
// // import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// Future<void>? _show;

// void ShowAdd(Future<void> nas) {
//   _show = nas;
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Management System',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _tabs = [
//     const EquipmentList(),
//     SparepartList(),
//     const MonitoringConditionList(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Management System'),
//       ),
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build),
//             label: 'Equipment',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.build_circle),
//             label: 'Sparepart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.monitor),
//             label: 'Monitoring Condition',
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_currentIndex == 0) {
//             _addEquipment(context);
//           } else if (_currentIndex == 1) {
//             _addSparepart(context);
//           } else if (_currentIndex == 2) {
//             _addMonitoring(context);
//             // Tambahkan fungsi untuk menambahkan Monitoring Condition
//           }
//         },
//         tooltip: 'Add',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Future<void> _addEquipment(BuildContext context) async {
//     // Tambahkan kode untuk menampilkan formulir tambah equipment di sini
//     // debugPrint("Equipment");
//     // const EquipmentList(runAdd: 1);
//     debugPrint("Equipment");
//   }

//   Future<void> _addSparepart(BuildContext context) async {
//     // Tambahkan kode untuk menampilkan formulir tambah sparepart di sini
//     _show!;
//   }

//   Future<void> _addMonitoring(BuildContext context) async {
//     // Tambahkan kode untuk menampilkan formulir tambah sparepart di sini
//     const MonitoringConditionList();
//   }
// }

// class SparepartList extends StatefulWidget {
//   @override
//   _SparepartListState createState() => _SparepartListState();
// }

// class _SparepartListState extends State<SparepartList> {
//   // ... Bagian kode yang diperlukan untuk menampilkan daftar sparepart

//   @override
//   Widget build(BuildContext context) {
//     // ... Bagian build widget untuk menampilkan daftar sparepart
//     return const Text("Sparepart");
//   }
// }
