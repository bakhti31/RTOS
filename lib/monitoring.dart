// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MonitoringConditionList extends StatefulWidget {
  const MonitoringConditionList({super.key});

  @override
  _MonitoringConditionListState createState() =>
      _MonitoringConditionListState();
}

class _MonitoringConditionListState extends State<MonitoringConditionList> {
  List<dynamic> _monitoringConditionList = [];

  @override
  void initState() {
    super.initState();
    _getMonitoringConditionList();
  }

  Future<void> _addMonitoringCondition() async {
    final response = await http.post(
      Uri.parse("http://192.168.1.250/rtos/api.php?monitoringcondition=1"),
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
      _getMonitoringConditionList();
    } else {
      throw Exception('Failed to add equipment');
    }
  }

  Future<void> _getMonitoringConditionList() async {
    final response = await http.get(
        Uri.parse('http://192.168.1.250/rtos/api.php?monitoringcondition=1'));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _monitoringConditionList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load monitoring condition');
    }
  }

  // Tambahkan fungsi tambahan seperti _addMonitoringCondition() di sini

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _monitoringConditionList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
              'Equipment ID: ${_monitoringConditionList[index]['equipment_id']}'),
          subtitle: Text(
              'Timestamp: ${_monitoringConditionList[index]['timestamp']}'),
        );
      },
    );
  }
}
