// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtos/homescreen.dart';

class MonitoringConditionList extends StatefulWidget {
  const MonitoringConditionList({super.key});

  @override
  _MonitoringConditionListState createState() =>
      _MonitoringConditionListState();
}

class _MonitoringConditionListState extends State<MonitoringConditionList> {
  List<dynamic> _monitoringConditionList = [];
  late List<TextEditingController> textController;
  late AlertDialog dialog;

  @override
  void initState() {
    super.initState();
    _getMonitoringConditionList();
    _addMonitoringCondition();
    setDialogController(textController, dialog);
  }

  Future<void> _addMonitoringCondition() async {
    final TextEditingController equipmentId = TextEditingController();
    final TextEditingController temperature = TextEditingController();
    final TextEditingController pressure = TextEditingController();
    final TextEditingController vibration = TextEditingController();
    final TextEditingController otherParameters = TextEditingController();
    List<TextEditingController> controllers = [
      equipmentId,
      temperature,
      pressure,
      vibration,
      otherParameters
    ];
    AlertDialog dialogs = AlertDialog(
      title: const Text('Add Equipment'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: equipmentId,
              decoration: const InputDecoration(labelText: 'ID of Equipment'),
            ),
            TextFormField(
              controller: temperature,
              decoration: const InputDecoration(labelText: 'Temperature'),
            ),
            TextFormField(
              controller: pressure,
              decoration: const InputDecoration(labelText: 'Pressure'),
            ),
            TextFormField(
              controller: vibration,
              decoration: const InputDecoration(labelText: 'Vibration'),
            ),
            TextFormField(
              controller: otherParameters,
              decoration: const InputDecoration(labelText: 'Other Paramters'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final response = await http.post(
              Uri.parse(
                  'http://192.168.1.250/rtos/api.php?monitoringcondition=1'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                "eqiupment_id": equipmentId.text,
                "temperature": temperature.text,
                "pressure": pressure.text,
                "vibration": vibration.text,
                "other_parameters": otherParameters.text
              }),
            );
            debugPrint(response.body);
            if (response.statusCode == 200) {
              // Refresh sparepart list after adding new sparepart
              _getMonitoringConditionList();
              Navigator.of(context).pop();
            } else {
              throw Exception('Failed to add Monitoring');
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
    textController = controllers;
    dialog = dialogs;

    // Old Code
    // final response = await http.post(
    //   Uri.parse("http://192.168.1.250/rtos/api.php?monitoringcondition=1"),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'equipment_name': 'New Equipment',
    //     'equipment_type': 'Type',
    //     'serial_number': 'SN123',
    //     'location': 'Location'
    //   }),
    // );
    // debugPrint(response.body);
    // if (response.statusCode == 200) {
    //   // Refresh equipment list after adding new equipment
    //   _getMonitoringConditionList();
    // } else {
    //   throw Exception('Failed to add equipment');
    // }
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
