import 'package:flutter/cupertino.dart';

class Report_screen extends StatefulWidget {
  const Report_screen({super.key});

  @override
  State<Report_screen> createState() => _Report_screenState();
}

class _Report_screenState extends State<Report_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Report '),
      ),
    );
  }
}