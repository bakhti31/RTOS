// import "dart:js";

import "dart:js";

import 'package:flutter/material.dart';
import "package:rtos/equipment.dart";
import "package:rtos/sparepart.dart";
import "package:rtos/monitoring.dart";

List<TextEditingController>? text_controllers;
AlertDialog? dialogs;

void setDialogController(
    List<TextEditingController> controllers, AlertDialog alertdialog) {
  text_controllers = controllers;
  dialogs = alertdialog;
}

Future<void> _add(BuildContext context) async {
  for (var element in text_controllers!) {
    element;
  }
  return showDialog(
      context: context,
      builder: (context) {
        return dialogs!;
      });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Equipment Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Equipment'),
              Tab(text: 'Spare Parts'),
              Tab(text: 'Monitoring Condition'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EquipmentList(),
            SparePartsList(),
            MonitoringConditionList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _add(context),
          tooltip: 'Add New Item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
