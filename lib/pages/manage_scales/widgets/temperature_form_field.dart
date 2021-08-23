import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureFormField extends StatefulWidget {
  final String labelText;
  final bool readOnly;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const TemperatureFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.validator,
  }) : super(key: key);

  @override
  _TemperatureFormFieldState createState() => _TemperatureFormFieldState();
}

class _TemperatureFormFieldState extends State<TemperatureFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: widget.validator,
    );
  }
}
