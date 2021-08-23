import 'package:conversor_termometrico/models/scale.dart';
import 'package:conversor_termometrico/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConverterWidget extends StatefulWidget {
  final HomeController homeController;

  const ConverterWidget({Key? key, required this.homeController})
      : super(key: key);

  @override
  _ConverterWidgetState createState() => _ConverterWidgetState();

  void update() {
    createState();
  }
}

class _ConverterWidgetState extends State<ConverterWidget> {
  final rowDividerWidth = 20.0;
  final List<DropdownMenuItem<Scale>> dropFromListItems = [];
  final List<DropdownMenuItem<Scale>> dropToListItems = [];

  final convertedValueTextController = TextEditingController();
  final inputValueTextController = TextEditingController();

  Scale? dropFromValue;
  Scale? dropToValue;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    initializeLists();
    inputValueTextController.text = '0';

    return Container(
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Valor de entrada',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^([0-9]+|([0-9]+(,|\.)[0-9]*))$'),
            ),
          ],
          controller: inputValueTextController,
          onChanged: (_) => convert(),
        ),
        Divider(height: 20, color: Colors.transparent),
        Observer(builder: (_) {
          print('Observer --> ${widget.homeController.counter} > $count');
          if (widget.homeController.counter > count) {
            count = widget.homeController.counter;
            dropFromListItems.clear();
            dropToListItems.clear();
            dropFromValue = null;
            dropToValue = null;
            initializeLists();
          }
          return dropDown(widget.homeController.scaleList);
        }),
        Divider(height: 20, color: Colors.transparent),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Valor convertido",
          ),
          readOnly: true,
          controller: convertedValueTextController,
        ),
      ]),
    );
  }

  Widget dropDown(variable) {
    print('dropDown');
    print('A->$dropFromListItems--B->$dropFromValue');
    print('C->${dropFromListItems.where((DropdownMenuItem<Scale> item) {
      print('${item.value} == $dropFromValue');
      return item.value == dropFromValue;
    }).length}');

    return Row(
      children: [
        Text('de'),
        VerticalDivider(width: rowDividerWidth),
        DropdownButton(
          items: dropFromListItems,
          value: dropFromValue,
          onChanged: onDropFromChange,
        ),
        VerticalDivider(width: rowDividerWidth * 2),
        Text('para'),
        VerticalDivider(width: rowDividerWidth),
        DropdownButton(
          items: dropToListItems,
          value: dropToValue,
          onChanged: onDropToChange,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  void onDropFromChange(Scale? scale) {
    dropFromValue = scale;
    setState(() {});
    convert();
  }

  void onDropToChange(Scale? scale) {
    dropToValue = scale;
    setState(() {});
    convert();
  }

  void convert() {
    if (inputValueTextController.text.isEmpty) {
      return;
    }

    var textInput = inputValueTextController.text.replaceAll(',', '.');
    var inputValue = double.parse(textInput);

    var inputScale = dropFromValue!;
    var outputScale = dropToValue!;

    var firstStep = (inputValue - inputScale.melting) /
        (inputScale.boiling - inputScale.melting);

    var secondStep = (outputScale.boiling - outputScale.melting);

    var result = firstStep * secondStep + outputScale.melting;
    convertedValueTextController.text =
        result.toStringAsFixed(2).replaceAll(',', '.');
  }

  void initializeLists() {
    print('initializeLists');

    if (dropFromListItems.isEmpty) {
      dropFromListItems.addAll(
        widget.homeController.scaleList.map(
          (e) => DropdownMenuItem<Scale>(value: e, child: Text(e.name)),
        ),
      );
    }

    if (dropFromValue == null) {
      dropFromValue = dropFromListItems.first.value;
    }

    if (dropToValue == dropFromValue) {
      dropToValue = null;
      dropToListItems.clear();
    }

    if (dropToListItems.isEmpty) {
      var scalesCopy = List<Scale>.from(widget.homeController.scaleList); //
      scalesCopy.removeWhere((element) => element == dropFromValue);

      dropToListItems.addAll(
        scalesCopy.map(
          (e) => DropdownMenuItem<Scale>(value: e, child: Text(e.name)),
        ),
      );
    }

    if (dropToValue == null) {
      dropToValue = dropToListItems.first.value;
    }
  }
}
