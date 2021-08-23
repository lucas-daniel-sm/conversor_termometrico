import 'package:flutter/material.dart';
import 'pages/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(primarySwatch: Colors.deepOrange);
    return MaterialApp(
      title: 'Conversor termométrico',
      theme: theme,
      home: Home(title: 'Conversor termométrico'),
    );
  }
}
