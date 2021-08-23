import 'package:conversor_termometrico/models/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'temperature_form_field.dart';

class ScaleEditor extends StatefulWidget {
  final Scale? value;

  const ScaleEditor({Key? key, this.value}) : super(key: key);

  @override
  _ScaleEditorState createState() => _ScaleEditorState();
}

class _ScaleEditorState extends State<ScaleEditor> {
  final controllerMeltingTemp = TextEditingController();
  final controllerBoilingTemp = TextEditingController();
  final controllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? degree;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      controllerBoilingTemp.text = widget.value!.boiling.toStringAsFixed(2);
      controllerMeltingTemp.text = widget.value!.melting.toStringAsFixed(2);
      controllerName.text = widget.value!.name;
    }

    if(degree == null) degree = widget.value?.degree ?? true;

    return SimpleDialog(
      title: Text('Editar escala'),
      children: [
        Form(
          key: formKey,
          child: Column(children: [
            Row(children: [
              Text('Nome: '),
              Expanded(
                child: TextFormField(
                  controller: controllerName,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ]),
            Divider(height: 20, color: Colors.transparent),
            buildRow('Temperatura de fusão da água: ', controllerMeltingTemp),
            Divider(height: 20, color: Colors.transparent),
            buildRow(
                'Temperatura de ebulição da água: ', controllerBoilingTemp),
            Divider(height: 20, color: Colors.transparent),
            Row(children: [
              Text('Escala em graus: '),
              Expanded(
                child: Checkbox(
                  value: degree,
                  onChanged: (value) => setState(() => degree = value!),
                  tristate: false,
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    getColor(states, context);
                  }),
                ),
              ),
            ]),
            Divider(height: 20, color: Colors.transparent),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  child: Text('Cancelar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              VerticalDivider(width: 20),
              Expanded(
                child: OutlinedButton(
                  child: Text('Confirmar'),
                  onPressed: () => validate(context),
                ),
              ),
            ])
          ]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
      contentPadding: EdgeInsets.all(20),
    );
  }

  void validate(context) {
    if (formKey.currentState!.validate()) {
      final result = Scale(
        name: controllerName.text,
        melting: double.parse(controllerMeltingTemp.text),
        boiling: double.parse(controllerBoilingTemp.text),
        degree: degree!,
      );
      Navigator.of(context).pop(result);
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Invalid values')));
  }

  Widget buildRow(txt, controller) {
    return Row(children: [
      Text(txt),
      Expanded(
        child: TemperatureFormField(
          labelText: '',
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some value';
            }
            return null;
          },
        ),
      ),
    ]);
  }

  Color getColor(Set<MaterialState> states, context) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    return states.any(interactiveStates.contains)
        ? Theme.of(context).accentColor
        : Colors.red;
  }
}
