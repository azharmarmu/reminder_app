import 'package:flutter/material.dart';

class HomeEmptyBody extends StatelessWidget {
  const HomeEmptyBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFFFFCF4),
      child: Column(
        children: [
          SizedBox(height: 24.0),
          Image.asset(
            'asset/image/empty_todo.jpeg',
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
          Text(
            'No Task',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Please add some task!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
    );
  }
}