// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rtos/homescreen.dart';

class SparePartsList extends StatefulWidget {
  const SparePartsList({super.key});

  @override
  _SparePartsListState createState() => _SparePartsListState();
}

class _SparePartsListState extends State<SparePartsList> {
  List<dynamic> _sparePartsList = [];
  late List<TextEditingController> textController;
  late AlertDialog dialog;
  @override
  void initState() {
    super.initState();
    _getSparePartsList();
    _addSparepart();
    setDialogController(textController, dialog);
  }

  Future<void> _getSparePartsList() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.250/rtos/api.php?sparepart=1'));
    debugPrint(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _sparePartsList = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load spare parts');
    }
  }

  Future<void> _addSparepart() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    List<TextEditingController> controllers = [
      nameController,
      numberController,
      quantityController,
      locationController
    ];
    // Initializing The Controller for textbox
    AlertDialog dialogs = AlertDialog(
      title: const Text('Add Sparepart'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
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
              _getSparePartsList();
              Navigator.of(context).pop();
            } else {
              throw Exception('Failed to add sparepart');
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
    //initializing the Box Of alert after clicking the Plus Button
    textController = controllers;
    dialog = dialogs;
  }

  // Tambahkan fungsi tambahan seperti _addSparePart() di sini

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sparePartsList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_sparePartsList[index]['part_name']),
          subtitle: Text(_sparePartsList[index]['location']),
          onTap: () {},
        );
      },
    );
  }
}
