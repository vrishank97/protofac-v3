// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteTaskPage extends StatelessWidget {
  final String projectId;
  final String taskId;

  DeleteTaskPage({required this.projectId, required this.taskId});

  void _deleteTask(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectId)
          .collection('tasks')
          .doc(taskId)
          .delete();
      Navigator.pop(context);
      print('Task deleted successfully');
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return AlertDialog(
    title: Text('Delete Task'),
    content: Text('Are you sure you want to delete this task?'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: ()=> _deleteTask(context),
        child: Text('Delete', style: TextStyle(color: Colors.red)),
      ),
    ],
  );
}
 
}
