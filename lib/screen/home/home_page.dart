import 'package:flutter/material.dart';
import 'package:reminder_app/screen/home/widget/home_empty.dart';
import 'package:reminder_app/screen/home/widget/home_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final List<Map<String, dynamic>> _taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _taskList.isNotEmpty ? HomeList(items: _taskList) : HomeEmptyBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFB51C),
        onPressed: () => _fabCLick(context),
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  final TextEditingController _titleController =  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _fabCLick(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (con) {
    //   return Container();
    // }));

    showDialog(
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
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: ()=>_addReminder(context),
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
  }

  void _addReminder(BuildContext context) {


    String _title = _titleController.text;
    String _description = _descriptionController.text;
    double _price = double.parse(_priceController.text);

    // Map<String, dynamic> _map = Map();
    // _map['title'] = _title;
    // _map['content'] = _description;
    // _map['price'] = _price;

    Map<String, dynamic> _map = {
      'title':_title,
      'content':_description,
      'price': _price
    };

    _taskList.add(_map);

    Navigator.of(context).pop();
  }
}
