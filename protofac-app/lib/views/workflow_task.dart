// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, library_private_types_in_public_api, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_protofac/widgets/add_task_dialog.dart';
import 'package:new_protofac/widgets/delete_task_dialog.dart';
import 'package:new_protofac/widgets/update_task_dialog.dart';
import 'package:share_plus/share_plus.dart';

class TaskCard extends StatelessWidget {
  final String projectId;
  final String taskId;
  final String taskName;
  final String created_at;

  TaskCard({
    required this.projectId,
    required this.taskId,
    required this.taskName,
    required this.created_at,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(227, 227, 227, 1)),
        color: Color(0xFFF6F8FD),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF1C69FF),
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: TextStyle(
                    color: Color(0xFF1C69FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF1C69FF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Task',
                      style: TextStyle(
                        color: Color(0xFF1C69FF),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Created At: ',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        created_at,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateTaskPage(
                          projectId: projectId,
                          taskId: taskId,
                        )),
              );
              print('Icon tapped');
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DeleteTaskPage(
                          projectId: projectId,
                          taskId: taskId,
                        )),
              );
            },
          )
        ],
      ),
    );
  }
}

// TaskCard class remains unchanged

class ProjectTasksPage extends StatefulWidget {
  final String projectId;
  final String projectName;

  ProjectTasksPage(
      {Key? key, required this.projectId, required this.projectName})
      : super(key: key);

  @override
  _ProjectTasksPageState createState() => _ProjectTasksPageState();
}

class _ProjectTasksPageState extends State<ProjectTasksPage> {

  String constructShareUrl(String projectId) {
  // Construct the URL using the project ID
  return 'https://your-website.com/projects/$projectId';
}

void _shareWorkflow(BuildContext context) async {
  String projectId = widget.projectId;
  String url = constructShareUrl(projectId);

  await Share.share(url);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F8FD),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              // color: Colors.white,
              child: Row(
                children: [
                  Padding(padding: const EdgeInsets.only(left: 16.0)),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Workflows',
                    selectionColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 48),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      widget.projectName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                  
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => {_shareWorkflow(context)} ,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular((10)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )
                      ),
                      child: Text("Share",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Color(0xFFF6F8FD),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('projects')
                      .doc(widget.projectId)
                      .collection('tasks')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const Text("No tasks found for this project.");
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final taskData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;

                        return TaskCard(
                          projectId: widget.projectId,
                          taskId: snapshot.data!.docs[index].id,
                          taskName: taskData['taskName'],
                          created_at: DateFormat('dd/MM/yyyy').format(
                              taskData['created_at']?.toDate() ??
                                  DateTime.now()),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddTaskAlertDialog(projectId: widget.projectId),
            ),
          );
        }, // Update the onPressed to call _addNewProject
        icon: Icon(Icons.add),
        label: Text('Task'),
        backgroundColor: Color.fromRGBO(28, 105, 255, 1),
      ),
    );
  }
}
