import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reminder_app/model/task_model.dart';
import 'package:reminder_app/screen/home/widget/home_empty.dart';
import 'package:reminder_app/screen/home/widget/home_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box boxTask;
  List<int> keys = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _setUpHiveBox(),
      builder: (_, snapshots) {
        if (snapshots.data != null) {
          keys = snapshots.data;
        }
        return Scaffold(
          appBar: keys.isNotEmpty
              ? AppBar(
                  title: Text('Reminder'),
                )
              : null,
          body: keys.isNotEmpty
              ? HomeList(keys: keys, box: boxTask)
              : HomeEmptyBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFFFB51C),
            onPressed: () => _fabCLick(context),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  void _fabCLick(BuildContext context) async {
    // Navigator.of(context).push(MaterialPageRoute(builder: (con) {
    //   return Container();
    // }));
    print('Before Dialog'); //1

    await showDialog(
      context: context,
      builder: (_) {
        final edgeInset = EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              margin: edgeInset,
              child: Container(
                padding: edgeInset,
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () => _addReminder(context),
                      child: Text('ADD'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
    setState(() {});
  }

  void _addReminder(BuildContext context) async {
    String _title = _titleController.text;
    String _description = _descriptionController.text;

    _clearController();

    TaskModel _taskModel = TaskModel(
      title: _title,
      description: _description,
    );
    await boxTask.add(_taskModel);

    Navigator.of(context).pop();
  }

  _clearController() {
    _titleController.clear();
    _descriptionController.clear();
  }

  Future<List<int>> _setUpHiveBox() async {
    boxTask = await Hive.openBox('task');
    return boxTask.keys.cast<int>().toList();
  }
}
