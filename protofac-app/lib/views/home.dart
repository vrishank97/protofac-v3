// ignore_for_file: prefer_const_constructors, unnecessary_import, unused_field, prefer_final_fields
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'workflow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:  Center(
            child: Projects(),
          ),
    );
  }
}
