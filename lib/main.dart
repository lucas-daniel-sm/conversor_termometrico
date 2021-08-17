import 'package:conversor_termometrico/models/scale.dart';
import 'package:conversor_termometrico/widgets/converter/converter_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Conversor termométrico'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      //
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          ConverterWidget(scales: [
            Scale(name: 'Celsius', melting: 0, boiling: 100, degree: true),
            Scale(name: 'Kelvin', melting: 273.15, boiling: 373.15, degree: false),
            Scale(name: 'Fahrenheit', melting: 32, boiling: 212, degree: false),
          ])
        ]),
      ),

      //Fab
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
