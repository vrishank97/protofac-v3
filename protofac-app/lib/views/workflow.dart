// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_protofac/views/workflow_task.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  // Add the _addNewProject function
  void _addNewProject() {
    TextEditingController _titleController = TextEditingController();
    ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);

    _titleController.addListener(
      () {
        _isButtonEnabled.value = _titleController.text.isNotEmpty;
      },
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "New Workflow",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Name of the Workflow",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Nunito'),
                ),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 290,
                height: 40,
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Add a name for the workflow',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ValueListenableBuilder<bool>(
                valueListenable: _isButtonEnabled,
                builder: (BuildContext context, bool isEnabled, Widget? child) {
                  return Container(
                    width: 300,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: isEnabled
                            ? Color.fromRGBO(28, 105, 255, 1)
                            : Colors.grey,
                      ),
                      onPressed: isEnabled
                          ? () {
                              if (_titleController.text.isNotEmpty) {
                                final currentUser =
                                    FirebaseAuth.instance.currentUser;
                                FirebaseFirestore.instance
                                    .collection('projects')
                                    .add({
                                  'userId': currentUser!
                                      .uid, // Add this line to store the user's ID
                                  'projectName': _titleController.text,
                                  'createdAt': FieldValue.serverTimestamp(),
                                  'updatedAt': FieldValue.serverTimestamp(),
                                });
                                Navigator.pop(context);
                              }
                            }
                          : null,
                      child: Text('Create a Workflow'),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "Protofac",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              right: 200,
            ),
          ),
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('projects')
                    .where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading');
                  }
                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      final projectData = doc.data() as Map<String, dynamic>;
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('projects')
                            .doc(doc.id)
                            .collection('tasks')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> taskSnapshot) {
                          int taskCount = 0;
                          if (taskSnapshot.hasData) {
                            taskCount = taskSnapshot.data!.docs.length;
                          }
                          return ProjectCard(
                            projectId: doc.id,
                            projectName: projectData['projectName'],
                            taskCount: taskCount,
                            createdAt:
                                ((projectData['createdAt'] as Timestamp?) ??
                                        Timestamp.now())
                                    .toDate(),
                            updatedAt:
                                ((projectData['updatedAt'] as Timestamp?) ??
                                        Timestamp.now())
                                    .toDate(),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            _addNewProject, // Update the onPressed to call _addNewProject
        icon: Icon(Icons.add),
        label: Text('Workflow'),
        backgroundColor: Color.fromRGBO(28, 105, 255, 1),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String projectId;
  final String projectName;
  final int taskCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectCard({
    required this.projectId,
    required this.projectName,
    required this.taskCount,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              projectName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Number of tasks: $taskCount',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Created At: ${DateFormat.yMMMd().format(createdAt)}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'Updated At: ${DateFormat.yMMMd().format(updatedAt)}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectTasksPage(
                projectId: projectId,
                projectName: projectName,
              ),
            ),
          );
        },
      ),
    );
  }
}
