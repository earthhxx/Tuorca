import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/activity/create/activity_create.dart';
import 'package:tuoc/model/activity/edit/activity_edit.dart';
import 'package:tuoc/model/base_model.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/page/activity_schedule/activity_create/activity_create_page.dart';
import 'package:tuoc/page/activity_schedule/activity_create/activity_validate.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/my_picker_time.dart';
import 'package:tuoc/util/string_format_util.dart';

import '../../../util/app_util.dart';

class ActivityCreatePresenter extends BasePresenter<ActivityCreatePage> {
  final formKey = GlobalKey<FormState>();
  MasterDataListModel masterData;

  DateTime dateStartSelected;
  DateTime dateEndSelected;
  DateTime _startTime;
  DateTime _endTime;

  String startTimeStr;
  String endTimeStr;
  String typeId;

  bool hasStartTime = true;
  bool hasEndTime = true;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController venueCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController dateStartCtrl = TextEditingController();
  TextEditingController participants1Ctrl = TextEditingController();
  TextEditingController participants2Ctrl = TextEditingController();
  TextEditingController dateEndCtrl = TextEditingController();

  StringFormatUtil _stringFormatUtil = StringFormatUtil();

  ActivityCreatePresenter(State<ActivityCreatePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    masterData = await AppUtil.getMasterData();
    if (state.widget.dataEdit == null) {
      dateStartSelected = state.widget.initialDate;
      dateEndSelected = state.widget.initialDate;
      dateStartCtrl.text = _stringFormatUtil.getDateInForm(dateStartSelected);
      dateEndCtrl.text = _stringFormatUtil.getDateInForm(dateEndSelected);
    } else {
      _setData();
    }
    loaded();
  }

  _setData() {
    var data = state.widget.dataEdit;

    dateStartSelected = DateTime.parse(data.schedule_start_datetime);
    dateEndSelected = DateTime.parse(data.schedule_end_datetime);
    dateStartCtrl.text = _stringFormatUtil.getDateInForm(dateStartSelected);
    dateEndCtrl.text = _stringFormatUtil.getDateInForm(dateEndSelected);
    _startTime = dateStartSelected;
    _endTime = dateEndSelected;
    startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
    endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
    typeId = data.activities_type_code;
    titleCtrl.text = data.title;
    venueCtrl.text = data.venue;
    participants1Ctrl.text = data.presenter_1;
    participants2Ctrl.text = data.presenter_2;
    remarkCtrl.text = data.remark;
  }

  getTime(int index) async {
    String time = await MyPickerTime(
      context: state.context,
      initialTime: index == 0 ? _startTime : _endTime,
      minTime: masterData.time_data.min,
      maxTime: masterData.time_data.max,
    ).getTime();

    var date = index == 0 ? dateStartSelected : dateEndSelected;

    if (time != null) {
      try {
        var myTime =
            DateTime.parse('${_stringFormatUtil.getDateForParse(date)} $time');
        if (index == 0) {
          if (_endTime != null && myTime.isAfter(_endTime) ||
              _endTime != null && myTime.isAtSameMomentAs(_endTime)) {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(date)} $time');
            endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
          }
//            throw('Time invalid');
          setState(() {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(date)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          });
        } else {
          if (_startTime != null && myTime.isBefore(_startTime) ||
              _startTime != null && myTime.isAtSameMomentAs(_startTime)) {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(date)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          }
//            throw('Time invalid');
          setState(() {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(date)} $time');
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

  onSelectStartDate(DateTime date) {
    if (date.isBefore(dateEndSelected) ||
        date.isAtSameMomentAs(dateEndSelected)) {
      setState(() {
        dateStartSelected = date;
        dateStartCtrl.text = _stringFormatUtil.getDateInForm(dateStartSelected);
        startTimeStr = 'Start';
        _startTime = null;
        endTimeStr = 'End';
        _endTime = null;
      });
    } else {
//      Alert(
//        state.context,
//        message: 'Date invalid',
//      );
      setState(() {
        dateStartSelected = date;
        dateEndSelected = date;
        dateStartCtrl.text = _stringFormatUtil.getDateInForm(dateStartSelected);
        dateEndCtrl.text = _stringFormatUtil.getDateInForm(dateEndSelected);
        startTimeStr = 'Start';
        _startTime = null;
        endTimeStr = 'End';
        _endTime = null;
      });
    }
  }

  onSelectEndDate(DateTime date) {
    if (date.isAfter(dateStartSelected) ||
        date.isAtSameMomentAs(dateStartSelected)) {
      setState(() {
        dateEndSelected = date;
        dateEndCtrl.text = _stringFormatUtil.getDateInForm(dateEndSelected);
        endTimeStr = 'End';
        _endTime = null;
      });
    } else {
//      Alert(
//        state.context,
//        message: 'Date invalid',
//      );
      setState(() {
        dateStartSelected = date;
        dateEndSelected = date;
        dateStartCtrl.text = _stringFormatUtil.getDateInForm(dateStartSelected);
        dateEndCtrl.text = _stringFormatUtil.getDateInForm(dateEndSelected);
        startTimeStr = 'Start';
        _startTime = null;
        endTimeStr = 'End';
        _endTime = null;
      });
    }
  }

  onTypeChanged(v) {
    setState(() {
      typeId = v;
    });
  }

  onSubmit() {
    ActivityValidate validate = ActivityValidate();
    if (_startTime == null && _endTime == null) {
      DateFormat date = DateFormat('yyyy-dd-MM');
      _startTime = DateTime.parse(
          "${date.format(dateStartSelected)} ${masterData.time_data.min}");
      _endTime = DateTime.parse(
          "${date.format(dateEndSelected)} ${masterData.time_data.max}");
    }

    if (state.widget.dataEdit == null) {
      var data = new ActivityCreateModel(
        schedule_start_date:
            _stringFormatUtil.getDateForParse(dateStartSelected),
        schedule_start_time: _stringFormatUtil.getTimeForParse(_startTime),
        schedule_end_date: _stringFormatUtil.getDateForParse(dateEndSelected),
        schedule_end_time: _stringFormatUtil.getTimeForParse(_endTime),
        activities_type_code: typeId ?? '',
        title: titleCtrl.text,
        presenter_1: participants1Ctrl.text,
        presenter_2: participants2Ctrl.text,
        remark: remarkCtrl.text,
        venue: venueCtrl.text,
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
      var data = new ActivityEditModel(
        activity_id: state.widget.dataEdit.activity_id,
        schedule_start_date:
            _stringFormatUtil.getDateForParse(dateStartSelected),
        schedule_start_time: _stringFormatUtil.getTimeForParse(_startTime),
        schedule_end_date: _stringFormatUtil.getDateForParse(dateEndSelected),
        schedule_end_time: _stringFormatUtil.getTimeForParse(_endTime),
        activities_type_code: typeId ?? '',
        title: titleCtrl.text,
        presenter_1: participants1Ctrl.text,
        presenter_2: participants2Ctrl.text,
        remark: remarkCtrl.text,
        venue: venueCtrl.text,
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

  _letCreate(ActivityCreateModel data) async {
    Api api = Api<BaseModel>();

    var res = await api.activityCreate(data.toJson());

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

  _letEdit(ActivityEditModel data) async {
    Api api = Api<BaseModel>();

    var res = await api.activityEdit(data.toJson());

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
