import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/model/surgery/surgery_create.dart';
import 'package:tuoc/model/surgery/surgery_edit.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/page/surgery_schedule/surgery_create/surgery_validate.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/color_util.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/my_picker_time.dart';
import 'package:tuoc/util/string_format_util.dart';

import '../../../util/app_util.dart';
import 'surgery_create_page.dart';

class SurgeryCreatePresenter extends BasePresenter<SurgeryCreatePage> {
  bool isEditState = false;

  MasterDataListModel masterData;
  var formKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  ScrollPhysics scrollPhysics = NeverScrollableScrollPhysics();

  var _setDXList = StreamController<List<TextEditingController>>();

  Stream get dxList => _setDXList.stream;

  var _setOPList = StreamController<List<TextEditingController>>();

  Stream get opList => _setOPList.stream;

  var _setImplantList = StreamController<List<TextEditingController>>();

  Stream get implantList => _setImplantList.stream;

  StringFormatUtil _stringFormatUtil = StringFormatUtil();

  List<TextEditingController> _listDX = [];
  List<TextEditingController> _listOP = [];
  List<TextEditingController> _listImplant = [];

  DateTime dateSelected;
  DateTime _startTime;
  DateTime _endTime;

  String startTimeStr;
  String endTimeStr;
  String staffId;
  String ageValue;
  String operativeCode;
  String group;
  String orderCode;

  Color groupColor;

  TextEditingController dateCtrl = TextEditingController();
  TextEditingController patientNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  TextEditingController hnCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController operativeRoomCtrl = TextEditingController();
  List<SurgeryRoomDataModel> listData = [];

  bool asesthStatus = true;
  bool vipStatus = false;
  bool hasStartTime = true;
  bool hasEndTime = true;

  int radioValue = 0;

  List<String> age;

  SurgeryCreatePresenter(State<SurgeryCreatePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    // loading();

    if (state.widget.dataEdit != null) isEditState = true;

    masterData = await AppUtil.getMasterData();
    age = _getAge();
    loaded();
    if (isEditState) {
      await _setEdit();
    } else {
      _listDX = [TextEditingController()];
      _listOP = [TextEditingController()];
      _listImplant = [TextEditingController()];
      _setDXList.add(_listDX);
      _setOPList.add(_listOP);
      _setImplantList.add(_listImplant);
      dateSelected = state.widget.initialDate;
      operativeRoomCtrl.text = state.widget.roomName;
      operativeCode = state.widget.roomId;
      dateCtrl.text = _stringFormatUtil.getDateInForm(state.widget.initialDate);
      setState(() {
        scrollPhysics = ScrollPhysics();
      });
    }
    loaded();
  }

  Future onRefresh() async {
    loading();

    await getRoom();

    loaded();
  }

  getRoom() async {
    loading();
    Api api = Api<SurgeryRoomModel>();

    var res = await api.getSurgeryRoom({});

    if (res.fail == null) {
      SurgeryRoomModel model = res.success;
      if (model.statusCode == 200) {
        listData = model.data;
        // print("listData = ${listData.length}");
      } else {
        _getRoomFail();
      }
    } else {
      _getRoomFail();
    }
  }

  _getRoomFail() {
    listData = [];
  }

  _setEdit() {
    var data = state.widget.dataEdit;
    // print("masterData.anesth_data => ${data.opd_ipd[0]}");
    // print("masterData.anesth_data => ${data.opd_ipd[1]}");
    // print("masterData.anesth_data => ${data.opd_ipd}");
    // print("masterData.anesth_data => ${data.op}");
    // print("masterData.anesth_data => ${data.op}");
    dateSelected = DateTime.parse(data.schedule_start_datetime);
    dateCtrl.text = _stringFormatUtil.getDateInForm(dateSelected);
    _startTime = dateSelected;
    startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
    _endTime = DateTime.parse(data.schedule_end_datetime);
    endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
    staffId = data.staff_code;
    patientNameCtrl.text = data.patient_name;
    ageCtrl.text = data.age.isNotEmpty ? data.age : null;
    phoneCtrl.text = data.phone_number;
    hnCtrl.text = data.hn;
    operativeRoomCtrl.text =
        data.operative_room_data != null && data.operative_room_data.isNotEmpty
            ? data.operative_room_data
            : '';
    operativeCode =
        data.operative_room_code.isNotEmpty ? data.operative_room_code : '';
    group = data.group_code.isNotEmpty ? data.group_code : null;
    groupColor = HexColor(data.group_color);
    orderCode = data.ordes_code.isNotEmpty ? data.ordes_code : null;
    asesthStatus = data.anesth_code == "YES" ? true : false;
    vipStatus =
        data.vip_code == "YES" || data.vip_code == "V-001" ? true : false;
    radioValue = data.opd_ipd.toLowerCase() == 'OPD' ? 0 : 1;
    remarkCtrl.text = data.remark;

    if (data.dx != null && data.dx.length > 0) {
      data.dx.forEach((item) {
        _listDX.add(TextEditingController(text: item));
      });
    }
    if (data.op != null && data.op.length > 0) {
      data.op.forEach((item) {
        _listOP.add(TextEditingController(text: item));
      });
    }
    if (data.implant != null && data.implant.length > 0) {
      data.implant.forEach((item) {
        _listImplant.add(TextEditingController(text: item));
      });
    }
    _setDXList.add(_listDX);
    _setOPList.add(_listOP);
    _setImplantList.add(_listImplant);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        scrollPhysics = ScrollPhysics();
      });
    });
  }

  getTime(int index) async {
    String time = await MyPickerTime(
      context: state.context,
      initialTime: index == 0 ? _startTime : _endTime,
      minTime: masterData.time_data.min,
      maxTime: masterData.time_data.max,
    ).getTime();

    if (time != null) {
      try {
        var myTime = DateTime.parse(
            '${_stringFormatUtil.getDateForParse(dateSelected)} $time');
        if (index == 0) {
          if (_endTime != null && myTime.isAfter(_endTime) ||
              _endTime != null && myTime.isAtSameMomentAs(_endTime)) {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(dateSelected)} $time');
            endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
          }
//            throw('Time invalid');
          setState(() {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(dateSelected)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          });
        } else {
          if (_startTime != null && myTime.isBefore(_startTime) ||
              _startTime != null && myTime.isAtSameMomentAs(_startTime)) {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(dateSelected)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          }
//            throw('Time invalid');
          setState(() {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(dateSelected)} $time');
            endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
          });
        }
      } catch (e) {
        Alert(
          state.context,
          message: '$e',
        );
      }
    }
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

  onAnesthChanged(bool value) {
    asesthStatus = value;
    // print("asesthStatus");
    // print(asesthStatus);
  }

  onVIPChanged(bool value) {
    vipStatus = value;
    // print(vipStatus);
  }

  onRadioChanged(int value) {
    radioValue = value;
  }

  onSelectDate(DateTime data) {
    setState(() {
      dateSelected = data;
      dateCtrl.text = _stringFormatUtil.getDateInForm(dateSelected);
    });
  }

  onSubmit() {
    print('onsubmit');
    // print(ageCtrl.text.toString());

    FocusScope.of(state.context).unfocus();
    SurgeryValidate validate = SurgeryValidate();
    if (isEditState) {
      var oldData = state.widget.dataEdit;
      var data = new SurgeryEditModel(
        surgery_id: oldData.surgery_id,
        room_id: operativeCode != "" ? operativeCode : state.widget.roomId,
        schedule_start_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_start_time: "00:00:00",
        schedule_end_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_end_time: "00:00:00",
        staff_code: staffId,
        patient_name: patientNameCtrl.text,
        age_code: ageCtrl.text.toString() ?? '',
        phone_number: phoneCtrl.text,
        hn: hnCtrl.text,
        operative_room_code: operativeCode ?? '',
        group_code: group ?? '',
        ordes_code: orderCode ?? '',
        anesth_code: asesthStatus == true ? 'YES' : 'NO',
        dx: jsonEncode(_listDX.map((item) => item.text).toList()),
        op: jsonEncode(_listOP.map((item) => item.text).toList()),
        implant: jsonEncode(_listImplant.map((item) => item.text).toList()),
        vip_code: vipStatus == true ? 'YES' : 'NO',
        opd_ipd: radioValue == 0 ? 'OPD' : 'IPD',
        remark: remarkCtrl.text,
      );
      print("onsave => ${data.toJson()}");
      if (formKey.currentState.validate()) {
        _checkTime();
        var result = validate.onEditValidate(state.context, data);

        if (result) {
          // if (_startTime.isAtSameMomentAs(_endTime)) {
          //   Alert(
          //     state.context,
          //     message: ResourceString.getString('time_cannot_same'),
          //   );
          //   return;
          // }
          _letEdit(data);
        }
      } else {
        _checkTime();
        _fillOutWarning();
      }
    } else {
      var data = new SurgeryCreateModel(
        room_id: operativeCode != "" ? operativeCode : state.widget.roomId,
        schedule_start_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_start_time: "00:00:00",
        schedule_end_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_end_time: "00:00:00",
        staff_code: staffId,
        patient_name: patientNameCtrl.text,
        age_code: ageCtrl.text.toString(),
        phone_number: phoneCtrl.text,
        hn: hnCtrl.text,
        operative_room_code: operativeCode ?? '',
        group_code: group ?? '',
        ordes_code: orderCode ?? '',
        anesth_code: masterData.anesth_data
            .where((w) => w.name == (asesthStatus ? 'YES' : 'NO'))
            .first
            .code,
        dx: jsonEncode(_listDX.map((item) => item.text).toList()),
        op: jsonEncode(_listOP.map((item) => item.text).toList()),
        implant: jsonEncode(_listImplant.map((item) => item.text).toList()),
        vip_code: masterData.vip_data
            .where((w) => w.name == (vipStatus ? 'YES' : 'NO'))
            .first
            .code,
        opd_ipd: radioValue == 0 ? 'OPD' : 'IPD',
        remark: remarkCtrl.text,
      );
      print("onsave => ${data.toJson()}");

      // print(data.schedule_end_time);
      // print(formKey.currentState.validate());
      if (formKey.currentState.validate()) {
        _checkTime();
        var result = validate.onValidate(state.context, data);

        if (result) {
          // if (_startTime.isAtSameMomentAs(_endTime)) {
          //   Alert(
          //     state.context,
          //     message: ResourceString.getString('time_cannot_same'),
          //   );
          //   return;
          // }

          _letCreate(data);
        }
      } else {
        _checkTime();
        _fillOutWarning();
      }
    }
  }

  _checkTime() {
    setState(() {
      if (startTimeStr == null ||
          startTimeStr.isEmpty ||
          startTimeStr == 'Start') {
        hasStartTime = false;
      } else {
        hasStartTime = true;
      }
      if (endTimeStr == null || endTimeStr.isEmpty || endTimeStr == 'End') {
        hasEndTime = false;
      } else {
        hasEndTime = true;
      }
    });
  }

  _fillOutWarning() {
    Alert(
      state.context,
      message: ResourceString.getString('fill_out_all_info'),
    );
  }

  _letCreate(SurgeryCreateModel data) async {
    Loading(state.context).show();
    Api api = Api<BaseModel>();

    var res = await api.surgeryCreate(data.toJson());

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, title: '', message: 'Create Success', onOk: () {
          Navigator.pop(state.context);
          // Navigator.push(context, Surg)
          // Navigator.pushReplacement(
          //   state.context,
          //   CupertinoPageRoute(
          //     builder: (_) => SurgeryScheduleListPage(
          //       roomId: operativeCode,
          //       roomName: operativeRoomCtrl.text,
          //     ),
          //   ),
          // );
        });
      } else {
        Alert(
          state.context,
          message: model.message,
        );
      }
    }
  }

  _letEdit(SurgeryEditModel data) async {
    Loading(state.context).show();
    Api api = Api<BaseModel>();

    var res = await api.surgeryEdit(data.toJson());

    Loading(state.context).hide();

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, message: 'Edit Success', onOk: () {
          Navigator.pop(state.context);
        });
      } else {
        Alert(
          state.context,
          message: model.message,
        );
      }
    }
  }

  dispose() {
    _setDXList.close();
    _setOPList.close();
    _setImplantList.close();
  }

  List<String> _getAge() {
    List<String> a = [];
    if (masterData.age_data != null) {
      for (var i = masterData.age_data.min; i <= masterData.age_data.max; i++) {
        a.add(i.toString());
      }

      return a;
    } else {
      return null;
    }
  }
}
