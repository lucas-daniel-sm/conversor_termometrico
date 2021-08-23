import 'package:conversor_termometrico/models/scale.dart';
import 'package:conversor_termometrico/pages/manage_scales/manage_scales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'home_controller.dart';
import 'widgets/converter_widget.dart';

class Home extends StatefulWidget {
  final String title;
  final homeController = HomeController();

  Home({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  HomeController get homeController => widget.homeController;

  @override
  Widget build(BuildContext context) {
    homeController.scaleList.forEach((Scale element) {
      print('|> ${element.name}');
    });

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [ConverterWidget(homeController: homeController)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Gerenciar escalas',
        child: Icon(Icons.thermostat),
        onPressed: () => openAddScreen(context),
        hoverColor: Theme.of(context).primaryColorDark,
      ),
    );
  }

  Future<void> openAddScreen(context) async {
    final addScreen = ManageScales(scaleList: homeController.scaleList);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (c) => addScreen),
    );
    if (result == null) return;

    result.forEach((Scale element) => print('>> ${element.name}'));

    setState(() => homeController.replaceList(result));
  }
}
