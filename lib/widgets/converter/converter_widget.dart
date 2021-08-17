import 'package:conversor_termometrico/models/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConverterWidget extends StatefulWidget {
  final Iterable<Scale> scales;

  const ConverterWidget({Key? key, required this.scales}) : super(key: key);

  @override
  _ConverterWidgetState createState() => _ConverterWidgetState();
}

class _ConverterWidgetState extends State<ConverterWidget> {
  final rowDividerWidth = 20.0;
  final List<DropdownMenuItem<Scale>> dropFromListItems = [];
  final List<DropdownMenuItem<Scale>> dropToListItems = [];
  Scale? dropFromValue;
  Scale? dropToValue;
  var convertedValueTextController = TextEditingController();
  var inputValueTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initializeLists();

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
        ),
        Divider(height: 20, color: Colors.transparent),
        Row(children: [
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
        ], mainAxisAlignment: MainAxisAlignment.start),
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

  void onDropFromChange(Scale? scale) {
    print('scale: ${scale?.name}');
    dropFromValue = scale;
    setState(() {});
    convert();
  }

  void onDropToChange(Scale? scale) {
    print('scale: ${scale?.name}');
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
    convertedValueTextController.text = result.toString().replaceAll(',', '.');
  }

  void initializeLists() {
    if (dropFromListItems.isEmpty) {
      dropFromListItems.addAll(
        widget.scales.map(
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
      var scalesCopy = List<Scale>.from(widget.scales); //
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
