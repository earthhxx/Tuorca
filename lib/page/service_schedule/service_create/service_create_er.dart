import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/master_data/master_data.dart';
import 'package:tuoc/model/service/create/service_or_create.dart';
import 'package:tuoc/model/service/detail/service_detail.dart';
import 'package:tuoc/model/service/edit/service_edit.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/my_picker_date.dart';
import 'package:tuoc/util/my_picker_time.dart';
import 'package:tuoc/util/string_format_util.dart';
import 'package:tuoc/util/validation.dart';
import 'package:tuoc/widget/calendar_icon.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_dropdown.dart';
import 'package:tuoc/widget/custom_textfield.dart';

import 'service_validate.dart';

// ignore: must_be_immutable
class ServiceCreateER extends StatefulWidget {
  final MasterDataListModel masterData;
  final DateTime initialDate;
  final Function onSubmit;
  final String typeCode;
  final ServiceDetailDataModel dataEdit;

  ServiceCreateER({
    Key key,
    this.masterData,
    this.initialDate,
    this.onSubmit,
    this.typeCode,
    this.dataEdit,
  }) : super(key: key);

  @override
  _ServiceCreateERState createState() => _ServiceCreateERState();
}

class _ServiceCreateERState extends State<ServiceCreateER> {
  final _fromKey = GlobalKey<FormState>();
  double _paddingField = 16;
  Widget _spaceBox = SizedBox(width: SizeService.getPadding(46));
  DateTime _startTime;
  DateTime _endTime;
  DateTime _dateSelected = DateTime.now();
  String _staffId;
  String _typeId;
  String startTimeStr;
  String endTimeStr;
  TextEditingController _r4Ctrl = TextEditingController();
  TextEditingController _r3Ctrl = TextEditingController();
  TextEditingController _r2Ctrl = TextEditingController();
  TextEditingController _r1Ctrl = TextEditingController();
  TextEditingController _internCtrl = TextEditingController();
  TextEditingController _dateCtrl = TextEditingController();
  TextEditingController _erDayTime = TextEditingController();
  StringFormatUtil _stringFormatUtil = StringFormatUtil();

  bool hasStartTime = true;
  bool hasEndTime = true;

  ServiceValidate validate = ServiceValidate();

  @override
  void initState() {
    super.initState();
    if (widget.dataEdit == null) {
      _dateSelected = widget.initialDate ?? _dateSelected;
      _dateCtrl.text = _stringFormatUtil.getDateInForm(_dateSelected);
    } else {
      _setData();
    }
  }

  _setData() {
    var data = widget.dataEdit;
    _dateSelected = DateTime.parse(data.schedule_start_datetime);
    _dateCtrl.text = _stringFormatUtil.getDateInForm(_dateSelected);
    _startTime = DateTime.parse(data.schedule_start_datetime);
    startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
    _endTime = DateTime.parse(data.schedule_end_datetime);
    endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
    _staffId = data.staff_code;
    _typeId = data.orthopaedic_subspecialties_code.isEmpty
        ? null
        : data.orthopaedic_subspecialties_code;
    _r4Ctrl.text = data.r_4;
    _r3Ctrl.text = data.r_3;
    _r2Ctrl.text = data.r_2;
    _r1Ctrl.text = data.r_1;
    _internCtrl.text = data.intern;
    _erDayTime.text = data.er_daytime;
  }

  _getTime(int index) async {
    String time = await MyPickerTime(
      context: context,
      initialTime: index == 0 ? _startTime : _endTime,
      minTime: widget.masterData.time_data.min,
      maxTime: widget.masterData.time_data.max,
    ).getTime();

    if (time != null) {
      try {
        var myTime = DateTime.parse(
            '${_stringFormatUtil.getDateForParse(_dateSelected)} $time');
        if (index == 0) {
          if (_endTime != null && myTime.isAfter(_endTime) ||
              _endTime != null && myTime.isAtSameMomentAs(_endTime)) {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(_dateSelected)} $time');
            endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
          }
          setState(() {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(_dateSelected)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          });
        } else {
          if (_startTime != null && myTime.isBefore(_startTime) ||
              _startTime != null && myTime.isAtSameMomentAs(_startTime)) {
            _startTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(_dateSelected)} $time');
            startTimeStr = _stringFormatUtil.getTimeFormat(_startTime);
          }
          setState(() {
            _endTime = DateTime.parse(
                '${_stringFormatUtil.getDateForParse(_dateSelected)} $time');
            endTimeStr = _stringFormatUtil.getTimeFormat(_endTime);
          });
        }
      } catch (e) {
        Alert(
          context,
          message: '$e',
        );
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
      context,
      message: ResourceString.getString('fill_out_all_info'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _titleDetail(context),
        Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () => MyPickerDate(
                        context,
                        initialDate: _dateSelected,
                        onSelected: (v) {
                          setState(() {
                            _dateSelected = v;
                          });

                          _dateCtrl.text =
                              _stringFormatUtil.getDateInForm(_dateSelected);
                        },
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        child: _textField(
                          controller: _dateCtrl,
                          enabled: false,
                          hint: ResourceString.getString('date'),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(SizeService.getPadding(26)),
                            child: CalendarIcon(),
                          ),
                          validator: Validation.emptyField,
                        ),
                      ),
                    ),
                  ),
                  _spaceBox,
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeService.getPadding(40),
                            vertical: SizeService.getPadding(34),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: SizeService.getPadding(16),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: hasStartTime && hasEndTime
                                  ? Color(0xff2E363C)
                                  : Theme.of(context).errorColor,
                              width: hasStartTime && hasEndTime ? 0.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: () => _getTime(0),
                                  child: Text(
                                    startTimeStr ??
                                        ResourceString.getString('start'),
                                    style: TextStyle(
                                      fontSize: SizeService.getFontSize(35),
                                      color: startTimeStr != null
                                          ? Color(0xff2E363C)
                                          : Color(0xff999999),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () => _getTime(1),
                                  child: Text(
                                    endTimeStr ??
                                        ResourceString.getString('end'),
                                    style: TextStyle(
                                      fontSize: SizeService.getFontSize(35),
                                      color: endTimeStr != null
                                          ? Color(0xff2E363C)
                                          : Color(0xff999999),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        !hasStartTime || !hasEndTime
                            ? Text('',
                                style: TextStyle(
                                    fontSize: SizeService.getFontSize(42)))
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              _dropdown(
                ResourceString.getString('staff_name'),
                initialValue: _staffId,
                onChanged: (v) {
                  setState(() {
                    _staffId = v;
                  });
                },
                validator: Validation.emptyField,
                items: widget.masterData != null
                    ? widget.masterData.staff_data.map((item) {
                        return DropdownMenuItem(
                          value: item.code,
                          child: Text(
                            item.name,
                          ),
                        );
                      }).toList()
                    : null,
              ),
              _dropdown(
                ResourceString.getString('type'),
                initialValue: _typeId,
                onChanged: (v) {
                  setState(() {
                    _typeId = v;
                  });
                },
                validator: Validation.emptyField,
                items: widget.masterData != null
                    ? widget.masterData.orthopaedic_subspecialties_data
                        .map((item) {
                        return DropdownMenuItem(
                          value: item.code,
                          child: Text(
                            item.name,
                          ),
                        );
                      }).toList()
                    : null,
              ),
              _textField(
                controller: _r4Ctrl,
                hint: ResourceString.getString('r4'),
              ),
              _textField(
                controller: _r3Ctrl,
                hint: ResourceString.getString('r3'),
              ),
              _textField(
                controller: _r2Ctrl,
                hint: ResourceString.getString('r2'),
              ),
              _textField(
                controller: _r1Ctrl,
                hint: ResourceString.getString('r1'),
              ),
              _textField(
                controller: _internCtrl,
                hint: ResourceString.getString('intern'),
              ),
              _textField(
                controller: _erDayTime,
                hint: ResourceString.getString('er_day_time'),
                validator: Validation.emptyField,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeService.getPadding(60),
                  bottom: SizeService.getPadding(90),
                ),
                child: CustomButton(
                  onPressed: () {
                    if (_fromKey.currentState.validate()) {
                      if (widget.dataEdit == null) {
                        var data = new ServiceCreateModel(
                          schedule_start_date:
                              _stringFormatUtil.getDateForParse(_dateSelected),
                          schedule_start_time:
                              _stringFormatUtil.getTimeForParse(_startTime),
                          schedule_end_date:
                              _stringFormatUtil.getDateForParse(_dateSelected),
                          schedule_end_time:
                              _stringFormatUtil.getTimeForParse(_endTime),
                          staff_code: _staffId ?? '',
                          service_type_code: widget.typeCode,
                          orthopaedic_subspecialties_code: _typeId ?? '',
                          r_1: _r1Ctrl.text,
                          r_2: _r2Ctrl.text,
                          r_3: _r3Ctrl.text,
                          r_4: _r4Ctrl.text,
                          intern: _internCtrl.text,
                          er_daytime: _erDayTime.text,
                        );
                        _checkTime();
                        var result = validate.onValidate(context, data);
                        if (result) {
                          if (widget.onSubmit != null) {
                            widget.onSubmit(data);
                          }
                        }
                      } else {
                        var data = new ServiceEditModel(
                          service_id: widget.dataEdit.service_id,
                          schedule_start_date:
                              _stringFormatUtil.getDateForParse(_dateSelected),
                          schedule_start_time:
                              _stringFormatUtil.getTimeForParse(_startTime),
                          schedule_end_date:
                              _stringFormatUtil.getDateForParse(_dateSelected),
                          schedule_end_time:
                              _stringFormatUtil.getTimeForParse(_endTime),
                          staff_code: _staffId ?? '',
                          service_type_code: widget.typeCode,
                          orthopaedic_subspecialties_code: _typeId ?? '',
                          r_1: _r1Ctrl.text,
                          r_2: _r2Ctrl.text,
                          r_3: _r3Ctrl.text,
                          r_4: _r4Ctrl.text,
                          intern: _internCtrl.text,
                          er_daytime: _erDayTime.text,
                        );
                        _checkTime();
                        var result = validate.onEditValidate(context, data);
                        if (result) {
                          if (widget.onSubmit != null) {
                            widget.onSubmit(data);
                          }
                        }
                      }
                    } else {
                      _checkTime();
                      _fillOutWarning();
                    }
                  },
                  radius: 10,
                  buttonText: ResourceString.getString(widget.dataEdit == null
                      ? 'create_schedule'
                      : 'edit_schedule'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _titleDetail(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Service Schedule : Type ER',
            style: CustomTextTheme.content(context),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    TextEditingController controller,
    String hint,
    Widget suffixIcon,
    int minLine = 1,
    int maxLine = 1,
    bool enabled = true,
    Function validator,
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboardType,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: CustomTextField(
        controller: controller,
        hintText: hint,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        suffixIcon: suffixIcon,
        maxLine: maxLine,
        minLine: minLine,
        enabled: enabled,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _dropdown(
    String name, {
    List<DropdownMenuItem> items,
    dynamic initialValue,
    Function onChanged,
    Function validator,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: CustomDropdown(
        hintText: '$name',
        initialValue: initialValue,
        onChanged: onChanged,
        items: items,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        validator: validator,
      ),
    );
  }
}
