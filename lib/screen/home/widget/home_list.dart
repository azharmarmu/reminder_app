import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/model/task_model.dart';

class HomeList extends StatelessWidget {
  final List<int> keys;
  final Box box;

  const HomeList({Key key, this.keys, this.box}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (BuildContext context, int index) {
        final int key = keys[index];
        final TaskModel data = box.get(key);

        return ListTile(
          leading: Icon(Icons.sticky_note_2_outlined),
          title: Text(data.title),
          subtitle: Text(data.description),
        );
      },
    );
  }
}
