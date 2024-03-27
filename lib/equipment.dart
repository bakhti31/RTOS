// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipmentList extends StatefulWidget {
  const EquipmentList({super.key});

  @override
  _EquipmentListState createState() => _EquipmentListState();

  static Function? run;
}

class _EquipmentListState extends State<EquipmentList> {
  List<dynamic> _equipmentList = [];

  @override
  void initState() {
    super.initState();
    _getEquipmentList();
  }

  Future<void> _addEquipment() async {
    final response = await http.post(
      Uri.parse("http://192.168.1.250/rtos/api.php?equipment=1"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'equipment_name': 'New Equipment',
        'equipment_type': 'Type',
        'serial_number': 'SN123',
        'location': 'Location'
      }),
    );
    debugPrint(response.body);
    if (response.statusCode == 200) {
      // Refresh equipment list after adding new equipment
      _getEquipmentList();
    } else {
      throw Exception('Failed to add equipment');
    }
  }

  Future<void> _getEquipmentList() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.250/rtos/api.php?equipment=1'));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _equipmentList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load equipment');
    }
  }

  // Tambahkan fungsi tambahan seperti _addEquipment() di sini

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _equipmentList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_equipmentList[index]['equipment_name']),
          subtitle: Text(_equipmentList[index]['location']),
        );
      },
    );
  }
}
