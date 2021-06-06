import 'package:flutter/material.dart';
import 'package:reminder_app/screen/home/widget/home_empty.dart';
import 'package:reminder_app/screen/home/widget/home_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final List<Map<String, dynamic>> _taskList = [
    {
      'title': 'Home work',
      'content': 'Do your home work',
      'price': 250,
    },
    {
      'title': 'Medication',
      'content': 'Take Tab before your sleep',
      'price': 350,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _taskList.isNotEmpty ? HomeList(items: _taskList) : HomeEmptyBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFB51C),
        onPressed: _fabCLick,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _fabCLick() {
    print('Fab Clicked');
  }
}
