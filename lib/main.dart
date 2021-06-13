import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_app/model/task_model.dart';
import 'package:reminder_app/screen/widgets/loading.dart';
import 'package:reminder_app/screen/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocDir.path)
    ..registerAdapter(TaskModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: userCheck(),
        builder: (context, snapshots) {
          print('${snapshots.connectionState}: ${snapshots.data}');
          if (snapshots.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }
          if (snapshots.data != null && snapshots.data) {
            return HomePage();
          }
          return LoginPage();
        },
      ),
    );
  }

  Future<bool> userCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(
      Duration(seconds: 2),
    );
    return prefs.getBool('userExist') ?? false;
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: false,
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    String _username = _usernameController.text.trim();
    String _password = _passwordController.text.trim();

    List<Map<String, dynamic>> users = [
      {'name': 'azhar', 'password': '12345678'},
      {'name': 'tariq', 'password': 'abcdefgh'},
    ];

    if (_username.isEmpty) {
      toast('Username cannot be empty!');
    } else if (_password.isEmpty) {
      toast('Password cannot be empty!');
    } else if (_password.length < 8) {
      toast('Password should be min 8 character');
    } else {
      bool loginStatus = false;
      for (int i = 0; i < users.length; i++) {
        Map<String, dynamic> user = users[i];
        if (_username == user['name']) {
          if (_password == user['password']) {
            loginStatus = true;
            break;
          }
        }
      }

      if (!loginStatus) {
        toast('Invalid credentials');
      } else {
        //key,value
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('userExist', loginStatus);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      }
    }
  }
}
