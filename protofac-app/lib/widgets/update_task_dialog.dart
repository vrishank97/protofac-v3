// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_build_context_synchronously, avoid_print, prefer_final_fields, unused_local_variable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTaskPage extends StatefulWidget {
  final String projectId;
  final String taskId;

  UpdateTaskPage({required this.projectId, required this.taskId});

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  TextEditingController taskTagController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  double _currentSlidervalue = 0;
  int?
      _totalUnits; // Create a nullable variable to store the total number of units

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateSliderValue);
    _fetchTotalUnits();
    _fetchCompletedUnits(); // Fetch the total units from Firestore when the widget is initialized
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSliderValue);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _storeActualDates(
      {DateTime? actualStart, DateTime? actualEnd}) async {
    Map<String, dynamic> updateData = {};

    if (actualStart != null) {
      updateData['actualStart'] = Timestamp.fromDate(actualStart);
    }
    if (actualEnd != null) {
      updateData['actualEnd'] = Timestamp.fromDate(actualEnd);
    }

    FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(widget.taskId)
        .update(updateData);
  }

  Future<void> _pickDate(BuildContext context, String dateType) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (dateType == 'actualStart') {
        await _storeActualDates(actualStart: pickedDate);
      } else if (dateType == 'actualEnd') {
        await _storeActualDates(actualEnd: pickedDate);
      }
    }
  }

  Future<void> _fetchCompletedUnits() async {
    try {
      DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .get();

      if (taskSnapshot.exists) {
        double? completedUnits =
            (taskSnapshot.data() as Map<String, dynamic>)['completedUnits'];
        if (completedUnits != null) {
          _controller.text = completedUnits.toString();
        }
      }
    } catch (e) {
      print('Error fetching completed units: $e');
    }
  }

  void _updateSliderValue() {
    double newValue = double.tryParse(_controller.text) ?? 0;
    if (newValue <= (_totalUnits ?? 0)) {
      setState(() {
        _currentSlidervalue = newValue;
      });
    } else {
      _controller.text = _currentSlidervalue.toString();
    }
  }

  Stream<DocumentSnapshot> _fetchTotalUnits() {
    return FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(widget.taskId)
        .snapshots();
  }

  Future<void> _updateCompletedUnits(double newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'completedUnits': newValue,
      });
      print('Completed units updated successfully');
    } catch (e) {
      print('Error updating completed units: $e');
    }
  }

  Stream<DocumentSnapshot> _fetchTaskData() {
    return FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .doc(widget.taskId)
        .snapshots();
  }

  void _updateTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(widget.projectId)
          .collection('tasks')
          .doc(widget.taskId)
          .update({
        'taskTag': taskTagController.text,
      });
      Navigator.pop(context);
      print('Task updated successfully');
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  String _getStatusText(double currentSlidervalue) {
    if (currentSlidervalue == 0) {
      return 'To Start';
    } else if (currentSlidervalue > 0 && currentSlidervalue < _totalUnits!) {
      return 'In Progress';
    } else {
      return 'Done';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'To Start':
        return Colors.grey;
      case 'In Progress':
        return Colors.yellow;
      case 'Done':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 50.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 10,
          ),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Task',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            height: 25.0 / 18.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            String? taskname = (snapshot.data!.data()
                                as Map<String, dynamic>)['taskName'];
                            return Text(
                              taskname!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            );
                          }
                          return Text('Loading...');
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            // Use data() method to get the data from the snapshot
                            Object? data = snapshot.data?.data();
                            Timestamp? created_at = (snapshot.data!.data()
                                as Map<String, dynamic>)['created_at'];
                            String createdAt = created_at != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                        created_at.millisecondsSinceEpoch)
                                    .toString()
                                    .substring(0, 10)
                                : '';

                            return Text(
                              'Created_at : $createdAt',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            );
                          }

                          return Text('Loading...');
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
                    decoration: BoxDecoration(
                      color: _getStatusColor(
                          _getStatusText(_currentSlidervalue)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      _getStatusText(_currentSlidervalue),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expected Start',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            Timestamp? expectedStartTimestamp = (snapshot.data!
                                .data() as Map<String, dynamic>)['startDate'];
                            String expectedStart =
                                expectedStartTimestamp != null
                                    ? DateTime.fromMillisecondsSinceEpoch(
                                            expectedStartTimestamp
                                                .millisecondsSinceEpoch)
                                        .toString()
                                        .substring(0, 10)
                                    : 'N/A';
                            return Text(
                              expectedStart,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            );
                          }

                          return Text('Loading...');
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Expected End',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            Timestamp? expectedEndTimestamp = (snapshot.data!
                                .data() as Map<String, dynamic>)['endDate'];
                            String expectedEnd = expectedEndTimestamp != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                        expectedEndTimestamp
                                            .millisecondsSinceEpoch)
                                    .toString()
                                    .substring(0, 10)
                                : 'N/A';
                            return Text(
                              expectedEnd,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            );
                          }

                          return Text('Loading...');
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(
                color: Color.fromRGBO(236, 236, 236, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Actual Start',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            Timestamp? actualStartTimestamp = (snapshot.data!
                                .data() as Map<String, dynamic>)['actualStart'];

                            String actualStart = actualStartTimestamp != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                        actualStartTimestamp
                                            .millisecondsSinceEpoch)
                                    .toString()
                                    .substring(0, 10)
                                : 'Pick a date';

                            return GestureDetector(
                              onTap: () => _pickDate(context, 'actualStart'),
                              child: Text(
                                actualStart,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }

                          return Text('Loading...');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Actual End',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: _fetchTaskData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData) {
                            Timestamp? actualEndTimestamp = (snapshot.data!
                                .data() as Map<String, dynamic>)['actualEnd'];

                            String actualEnd = actualEndTimestamp != null
                                ? DateTime.fromMillisecondsSinceEpoch(
                                        actualEndTimestamp
                                            .millisecondsSinceEpoch)
                                    .toString()
                                    .substring(0, 10)
                                : 'Pick a date';

                            return GestureDetector(
                              onTap: () => _pickDate(context, 'actualEnd'),
                              child: Text(
                                actualEnd,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }

                          return Text('Loading...');
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Completed Units',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 148,
                            height: 40,
                            child: TextFormField(
                              controller: _controller,
                              onChanged: (value) async {
                                _updateSliderValue();
                                double newValue = double.tryParse(value) ?? 0;
                                if (newValue <= (_totalUnits ?? 0)) {
                                  await _updateCompletedUnits(newValue);
                                }
                              },
                              validator: (value) {
                                double? enteredValue =
                                    double.tryParse(value ?? '');
                                if (_totalUnits != null &&
                                    (enteredValue == null ||
                                        enteredValue > _totalUnits!)) {
                                  return 'Value must be less than or equal to $_totalUnits';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Please enter a value',
                              ),
                            ),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: _fetchTotalUnits(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                      ConnectionState.active &&
                                  snapshot.hasData) {
                                var targetUnits =
                                    snapshot.data!.get('targetUnits');
                                if (targetUnits is int) {
                                  _totalUnits = targetUnits;
                                } else if (targetUnits is String) {
                                  _totalUnits = int.tryParse(targetUnits);
                                } else {
                                  _totalUnits = null;
                                }
                                return Text(_totalUnits != null
                                    ? '/$_totalUnits'
                                    : 'Nothing');
                              }

                              return Text('Loading...');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Progress of Task',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.green,
                            disabledActiveTrackColor: Colors.green,
                            inactiveTrackColor:
                                Color.fromARGB(255, 183, 183, 183),
                            trackHeight: 24.0,
                            thumbColor: Colors.black,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 12.0,
                              pressedElevation: 8.0,
                            ),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 14.0),
                            valueIndicatorShape:
                                const PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.black,
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          child: Slider(
                            value: _currentSlidervalue,
                            min: 0,
                            max: _totalUnits != null
                                ? _totalUnits!.toDouble()
                                : 100,
                            // onChanged: (double newValue) {
                            //   setState(() {
                            //     _currentSlidervalue = newValue;

                            //   });
                            //   // onChanged:null,
                            // },
                            onChanged: null,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Container(
                width: 300,
                height: 85,
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Color.fromRGBO(28, 105, 255, 1)),
                  onPressed: () => _updateTask(),
                  child: const Text('Update Task'),
                ),
              ),
              const SizedBox(
                height: 29,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
