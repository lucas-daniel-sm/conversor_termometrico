import 'package:conversor_termometrico/models/scale.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  int counter = 0;

  @observable
  List<Scale> scaleList;

  _HomeController()
      : scaleList = <Scale>[
          Scale(name: 'Celsius', melting: 0, boiling: 100, degree: true),
          Scale(
            name: 'Kelvin',
            melting: 273.15,
            boiling: 373.15,
            degree: false,
          ),
          Scale(name: 'Fahrenheit', melting: 32, boiling: 212, degree: true),
        ];

  @action
  void replaceList(List<Scale> list) {
    scaleList = list;
    counter++;
  }
}
