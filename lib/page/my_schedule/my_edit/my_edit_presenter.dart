import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';

class MyEditPresenter extends BasePresenter {
  var _setDXList = StreamController<List<TextEditingController>>();
  Stream get dxList => _setDXList.stream;

  var _setOPList = StreamController<List<TextEditingController>>();
  Stream get opList => _setOPList.stream;

  var _setImplantList = StreamController<List<TextEditingController>>();
  Stream get implantList => _setImplantList.stream;

  List<TextEditingController> _listDX = [TextEditingController()];
  List<TextEditingController> _listOP = [TextEditingController()];
  List<TextEditingController> _listImplant = [TextEditingController()];

  MyEditPresenter(State<StatefulWidget> state) : super(state);

  _initPage() {
    _setDXList.add(_listDX);
    _setOPList.add(_listOP);
    _setImplantList.add(_listImplant);
  }

  onDXAdd() {
    _listDX.add(TextEditingController());
    setState(() {
      _setDXList.add(_listDX);
    });
  }

  onDXRemove(int index) {
    _listDX.removeAt(index);
    setState(() {
      _setDXList.add(_listDX);
    });
  }

  onOPAdd() {
    _listOP.add(TextEditingController());
    setState(() {
      _setOPList.add(_listOP);
    });
  }

  onOPRemove(int index) {
    _listOP.removeAt(index);
    setState(() {
      _setOPList.add(_listOP);
    });
  }

  onImplantAdd() {
    _listImplant.add(TextEditingController());
    setState(() {
      _setImplantList.add(_listImplant);
    });
  }

  onImplantRemove(int index) {
    _listImplant.removeAt(index);
    setState(() {
      _setImplantList.add(_listImplant);
    });
  }

  onAnesthChanged(bool value) {}

  onVIPChanged(bool value) {}

  dispose() {
    _setDXList.close();
    _setOPList.close();
    _setImplantList.close();
  }
}
