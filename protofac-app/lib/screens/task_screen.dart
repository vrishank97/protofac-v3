// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:new_protofac/views/workflow_task.dart';

import 'profile_screen.dart';
import 'report_screen.dart';

class Task_screen extends StatefulWidget {
  const Task_screen({super.key});

  @override
  State<Task_screen> createState() => _Task_screenState();
}

class _Task_screenState extends State<Task_screen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
  ProjectTasksPage(projectId: '', projectName: '',),
  Report_screen(),
  ProfilePage(),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[ _selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/workflow.png', height: 17, width: 17),
            label: 'Workflows',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/report.png', height: 15, width: 15),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
