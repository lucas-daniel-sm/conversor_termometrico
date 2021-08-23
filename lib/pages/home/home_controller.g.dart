// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$scaleListAtom = Atom(name: '_HomeController.scaleList');

  @override
  List<Scale> get scaleList {
    _$scaleListAtom.reportRead();
    return super.scaleList;
  }

  @override
  set scaleList(List<Scale> value) {
    _$scaleListAtom.reportWrite(value, super.scaleList, () {
      super.scaleList = value;
    });
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  void replaceList(List<Scale> list) {
    final _$actionInfo = _$_HomeControllerActionController.startAction(
        name: '_HomeController.replaceList');
    try {
      return super.replaceList(list);
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scaleList: ${scaleList}
    ''';
  }
}
