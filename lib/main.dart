import 'package:flutter/material.dart';
import 'package:zendays/homeuser.dart';
import 'package:zendays/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home_user': (context) => HomeUsuarioPage(),
      },
    );
  }
}