import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/academic/detail/academic_detail.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/my_picker_date.dart';
import 'package:tuoc/util/validation.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_icon.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_dropdown.dart';
import 'package:tuoc/widget/custom_textfield.dart';

import 'academic_create_presenter.dart';

class AcademicCreatePage extends StatefulWidget {
  final DateTime initialDate;
  final AcademicDetailDataModel dataEdit;

  AcademicCreatePage({Key key, this.initialDate, this.dataEdit})
      : super(key: key);

  @override
  _AcademicCreatePageState createState() => _AcademicCreatePageState();
}

class _AcademicCreatePageState extends State<AcademicCreatePage> {
  AcademicCreatePresenter _presenter;
  double _paddingField = 16;
  Widget _spaceBox = SizedBox(width: SizeService.getPadding(46));

  @override
  void initState() {
    super.initState();

    _presenter = AcademicCreatePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseContainer(
        title: ResourceString.getString(
            widget.dataEdit == null ? 'create_schedule' : 'edit_schedule'),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: SizeService.getPadding(72),
                  left: SizeService.getPadding(52),
                  right: SizeService.getPadding(52),
                  bottom: MediaQuery.of(context).padding.bottom +
                      SizeService.getPadding(52)),
              child: Column(
                children: <Widget>[
                  _titleDetail(),
                  _createForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleDetail() {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeService.getPadding(24)),
      child: Row(
        children: <Widget>[
          Text(
            '${ResourceString.getString('academic_schedule')}',
            style: CustomTextTheme.content(context),
          ),
        ],
      ),
    );
  }

  Widget _createForm() {
    return _presenter.masterData == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _presenter.formKey,
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
                          initialDate: _presenter.dateSelected,
                          onSelected: _presenter.onSelectDate,
                        ),
                        child: Container(
                          color: Colors.white.withOpacity(0.1),
                          child: _textField(
                            controller: _presenter.dateCtrl,
                            enabled: false,
                            hint: ResourceString.getString('date'),
                            suffixIcon: Padding(
                              padding:
                                  EdgeInsets.all(SizeService.getPadding(26)),
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
                                color: _presenter.hasStartTime &&
                                        _presenter.hasEndTime
                                    ? Color(0xff2E363C)
                                    : Theme.of(context).errorColor,
                                width: _presenter.hasStartTime &&
                                        _presenter.hasEndTime
                                    ? 0.5
                                    : 1,
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _presenter.getTime(0),
                                    child: Text(
                                      _presenter.startTimeStr ??
                                          ResourceString.getString('start'),
                                      style: TextStyle(
                                        fontSize: SizeService.getFontSize(35),
                                        color: _presenter.startTimeStr != null
                                            ? Color(0xff2E363C)
                                            : Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _presenter.getTime(1),
                                    child: Text(
                                      _presenter.endTimeStr ??
                                          ResourceString.getString('end'),
                                      style: TextStyle(
                                        fontSize: SizeService.getFontSize(35),
                                        color: _presenter.endTimeStr != null
                                            ? Color(0xff2E363C)
                                            : Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          !_presenter.hasStartTime || !_presenter.hasEndTime
                              ? Text('',
                                  style: TextStyle(
                                      fontSize: SizeService.getFontSize(42)))
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
                _presenter.masterData == null
                    ? Container()
                    : _dropdown(
                        ResourceString.getString('type'),
                        initialValue: _presenter.typeId,
                        onChanged: _presenter.onTypeChanged,
                        validator: Validation.emptyField,
                        items: _presenter.masterData != null
                            ? _presenter.masterData.academic_type_data
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
                  controller: _presenter.titleCtrl,
                  hint: ResourceString.getString('title'),
                  validator: Validation.emptyField,
                ),
                _textField(
                  controller: _presenter.participants1Ctrl,
                  hint: ResourceString.getString('praticipants') + ' 1',
                ),
                _textField(
                  controller: _presenter.participants2Ctrl,
                  hint: ResourceString.getString('praticipants') + ' 2',
                ),
                _presenter.masterData == null
                    ? Container()
                    : _dropdown(
                        ResourceString.getString('advidor'),
                        initialValue: _presenter.advidorId,
                        onChanged: _presenter.onAdvidorChanged,
                        validator: Validation.emptyField,
                        items: _presenter.masterData != null
                            ? _presenter.masterData.staff_data.map((item) {
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
                  controller: _presenter.remarkCtrl,
                  hint: ResourceString.getString('remark'),
                  minLine: 3,
                  maxLine: 3,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeService.getPadding(60),
                    bottom: SizeService.getPadding(90),
                  ),
                  child: CustomButton(
                    onPressed: _presenter.onSubmit,
                    radius: 10,
                    buttonText: ResourceString.getString(widget.dataEdit == null
                        ? 'create_schedule'
                        : 'edit_schedule'),
                  ),
                ),
              ],
            ),
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
        items: items,
        initialValue: initialValue,
        onChanged: onChanged,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        validator: widget.dataEdit == null ? validator : null,
      ),
    );
  }
}
