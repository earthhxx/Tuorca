import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/academic/create/academic_create.dart';
import 'package:tuoc/model/academic/edit/academic_edit.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/page/academic_schedule/academic_create/academic_validate.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/my_picker_time.dart';
import 'package:tuoc/util/string_format_util.dart';

import '../../../util/app_util.dart';
import 'academic_create_page.dart';

class AcademicCreatePresenter extends BasePresenter<AcademicCreatePage> {
  final formKey = GlobalKey<FormState>();
  MasterDataListModel masterData;

  DateTime dateSelected;
  DateTime _startTime;
  DateTime _endTime;

  String startTimeStr;
  String endTimeStr;
  String typeId;
  String advidorId;

  bool hasStartTime = true;
  bool hasEndTime = true;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController participants1Ctrl = TextEditingController();
  TextEditingController participants2Ctrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  StringFormatUtil _stringFormatUtil = StringFormatUtil();

  AcademicCreatePresenter(State<AcademicCreatePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    masterData = await AppUtil.getMasterData();
    if (state.widget.dataEdit == null) {
      dateSelected = state.widget.initialDate;
      dateCtrl.text = _stringFormatUtil.getDateInForm(dateSelected);
    } else {
      _setData();
    }
    loaded();
  }

  _setData() {
    var data = state.widget.dataEdit;

    dateSelected = DateTime.parse(data.schedule_start_datetime);
    dateCtrl.text = _stringFormatUtil.getDateInForm(dateSelected);
    _startTime = DateTime.parse(data.schedule_start_datetime);
    startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
    _endTime = DateTime.parse(data.schedule_end_datetime);
    endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
    typeId = data.academic_type_code;
    titleCtrl.text = data.title;
    participants1Ctrl.text = data.presenter_1;
    participants2Ctrl.text = data.presenter_2;
    advidorId = data.advisor_code;
    remarkCtrl.text = data.remark;
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

  onTypeChanged(v) {
    setState(() {
      typeId = v;
    });
  }

  onAdvidorChanged(v) {
    setState(() {
      advidorId = v;
    });
  }

  onSelectDate(DateTime data) {
    setState(() {
      dateSelected = data;
      dateCtrl.text = _stringFormatUtil.getDateInForm(dateSelected);
    });
  }

  onSubmit() {
    AcademicValidate validate = AcademicValidate();
    if (state.widget.dataEdit == null) {
      var data = new AcademicCreateModel(
        schedule_start_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_start_time: _stringFormatUtil.getTimeForParse(_startTime),
        schedule_end_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_end_time: _stringFormatUtil.getTimeForParse(_endTime),
        academic_type_code: typeId ?? '',
        title: titleCtrl.text,
        presenter_1: participants1Ctrl.text,
        presenter_2: participants2Ctrl.text,
        advisor_code: advidorId ?? '',
        remark: remarkCtrl.text,
      );

      if (formKey.currentState.validate()) {
        _checkTime();
        var result = validate.onValidate(state.context, data);

        if (result) {
          if (_startTime.isAtSameMomentAs(_endTime)) {
            Alert(
              state.context,
              message: ResourceString.getString('time_cannot_same'),
            );
            return;
          }

          _letCreate(data);
        }
      } else {
        _checkTime();
        _fillOutWarning();
      }
    } else {
      var data = new AcademicEditModel(
        academic_id: state.widget.dataEdit.academic_id,
        schedule_start_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_start_time: _stringFormatUtil.getTimeForParse(_startTime),
        schedule_end_date: _stringFormatUtil.getDateForParse(dateSelected),
        schedule_end_time: _stringFormatUtil.getTimeForParse(_endTime),
        academic_type_code: typeId ?? '',
        title: titleCtrl.text,
        presenter_1: participants1Ctrl.text,
        presenter_2: participants2Ctrl.text,
        advisor_code: advidorId ?? '',
        remark: remarkCtrl.text,
      );

      if (formKey.currentState.validate()) {
        _checkTime();
        var result = validate.onEditValidate(state.context, data);

        if (result) {
          if (_startTime.isAtSameMomentAs(_endTime)) {
            Alert(
              state.context,
              message: ResourceString.getString('time_cannot_same'),
            );
            return;
          }

          _letEdit(data);
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

  _letCreate(AcademicCreateModel data) async {
    Api api = Api<BaseModel>();

    var res = await api.academicCreate(data.toJson());

    if (res.fail == null) {
      BaseModel model = res.success;
      if (model.statusCode == 200) {
        Alert(state.context, title: '', message: 'Create Success', onOk: () {
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

  _letEdit(AcademicEditModel data) async {
    Api api = Api<BaseModel>();

    var res = await api.academicEdit(data.toJson());

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
}
