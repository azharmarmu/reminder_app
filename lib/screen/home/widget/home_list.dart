import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const HomeList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.edit,
          ),
          title: Text(items[index]['title']),
          subtitle: Text(items[index]['content']),
          trailing: Text(items[index]['price'].toString()),
        );
      },
    );
  }
}
