// ignore_for_file: library_private_types_in_public_api, must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtos/homescreen.dart';

class EquipmentList extends StatefulWidget {
  const EquipmentList({super.key});

  @override
  _EquipmentListState createState() => _EquipmentListState();

  static Function? run;
}

class _EquipmentListState extends State<EquipmentList> {
  List<dynamic> _equipmentList = [];
  late List<TextEditingController> textController;
  late AlertDialog dialog;
  @override
  void initState() {
    super.initState();
    _getEquipmentList();
    _addEquipment();
    setDialogController(textController, dialog);
  }

  Future<void> _addEquipment() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    final TextEditingController serialNumberController =
        TextEditingController();
    final TextEditingController locationController = TextEditingController();
    List<TextEditingController> controllers = [
      nameController,
      typeController,
      serialNumberController,
      locationController
    ];
    AlertDialog dialogs = AlertDialog(
      title: const Text('Add Equipment'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextFormField(
              controller: serialNumberController,
              decoration: const InputDecoration(labelText: 'Serial Number'),
            ),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
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
                  'http://monitoring-apps.infinityfreeapp.com/api.php?equipment=1'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'equipment_name': nameController.text,
                'equipment_type': typeController.text,
                'serial_number': serialNumberController.text,
                'location': locationController.text,
              }),
            );

            if (response.statusCode == 200) {
              // Refresh sparepart list after adding new sparepart
              _getEquipmentList();
              Navigator.of(context).pop();
            } else {
              throw Exception('Failed to add Equipment');
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
    textController = controllers;
    dialog = dialogs;

    //old code
    // final response = await http.post(
    //   Uri.parse("http://sdm-management.infinityfreeapp.com/api.php?equipment=1"),
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
    //   _getEquipmentList();
    // } else {
    //   throw Exception('Failed to add equipment');
    // }
  }

  Future<void> _getEquipmentList() async {
    final response = await http.get(Uri.parse(
        'http://monitoring-apps.infinityfreeapp.com/api.php?equipment=1'));
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
