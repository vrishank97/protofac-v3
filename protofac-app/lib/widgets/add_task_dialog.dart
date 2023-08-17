// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskAlertDialog extends StatefulWidget {
  final String projectId;
  const AddTaskAlertDialog({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController targetUnitsController = TextEditingController();
  final Map<String, Color> taskTags = {
    'To START': Colors.black,
    'PROGRESS': Colors.black,
    'DONE': Colors.black,
  };
  late String selectedValue = '';
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('New Task', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 0),
        child: Form(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Task Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    child: TextFormField(
                      controller: taskNameController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        hintText: 'Add Task Name',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Target Units",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: targetUnitsController,
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        hintText: 'Add Number of Units to be completed',
                        hintStyle: const TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Expected Dates",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Nunito'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectStartDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedStartDate == null
                                      ? 'Select a start date'
                                      : 'Start Date: ${DateFormat('dd/MM/yyyy').format(selectedStartDate!)}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const Icon(CupertinoIcons.calendar,
                                    color: Colors.brown),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectEndDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedEndDate == null
                                      ? 'Select an end date'
                                      : 'End Date: ${DateFormat('dd/MM/yyyy').format(selectedEndDate!)}',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const Icon(CupertinoIcons.calendar,
                                    color: Colors.brown),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      final taskName = taskNameController.text;
                      final targetUnits = targetUnitsController.text;
                      if (taskName.isNotEmpty &&
                          targetUnits.isNotEmpty
                          ) 
                          {
                        _addTasks(
                          taskName: taskName,
                          targetUnits: targetUnits,
                        ).then((value) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all the fields'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 300,
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(28, 105, 255, 1),
                            Color.fromRGBO(66, 143, 255, 1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Create Task',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate)
      setState(() {
        selectedStartDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: selectedStartDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
      });
  }

  Future _addTasks(
      {required String taskName,
      required String targetUnits}) async {
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .add(
      {
        'taskName': taskName,
        'targetUnits': targetUnits,
        'startDate': selectedStartDate?.toUtc(),
        'endDate': selectedEndDate?.toUtc(),
        'created_at': DateTime.now().toLocal(),
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(taskId)
        .update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.clear();
    targetUnitsController.clear();
    setState(() {
      selectedValue = '';
      selectedStartDate = null;
      selectedEndDate = null;
    });
  }
}
