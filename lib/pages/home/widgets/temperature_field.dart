import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureField extends StatefulWidget {
  final String labelText;
  final bool readOnly;
  final TextEditingController controller;

  const TemperatureField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _TemperatureFieldState createState() => _TemperatureFieldState();
}

class _TemperatureFieldState extends State<TemperatureField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
      ),
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^([0-9]+|([0-9]+(,|\.)[0-9]*))$'),
        ),
      ],
    );
  }
}
