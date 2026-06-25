import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/surgery/surgery_detail.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/color_util.dart';
import 'package:tuoc/util/my_picker_date.dart';
import 'package:tuoc/util/validation.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_icon.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_dropdown.dart';
import 'package:tuoc/widget/custom_radio_group.dart';
import 'package:tuoc/widget/custom_textfield.dart';
import 'package:tuoc/widget/data_not_found.dart';
import 'package:tuoc/widget/text_field_dynamic_list.dart';
import 'package:tuoc/widget/yes_no_input_field.dart';

import 'surgery_create_presenter.dart';

class SurgeryCreatePage extends StatefulWidget {
  final DateTime initialDate;
  final String roomId;
  final String roomName;
  final SurgeryDetailDataModel dataEdit;

  SurgeryCreatePage({
    Key key,
    this.initialDate,
    this.roomId,
    this.roomName,
    this.dataEdit,
  }) : super(key: key);

  @override
  _SurgeryCreatePageState createState() => _SurgeryCreatePageState();
}

class _SurgeryCreatePageState extends State<SurgeryCreatePage> {
  SurgeryCreatePresenter _presenter;

  double _paddingField = 16;
  bool checkRoom = false;
  String selectRoomID = "";
  String selectRoomName = "";
  Widget _spaceBox = SizedBox(width: SizeService.getPadding(46));
  double height = 0;

  @override
  void initState() {
    super.initState();

    _presenter = SurgeryCreatePresenter(this);
    _presenter.getRoom();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_presenter.listData.length > 0) {
      height = _presenter.listData.length * 200.00;
      // print("height = ${height}");
    }
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
              physics: _presenter.scrollPhysics,
              padding: EdgeInsets.only(
                  top: SizeService.getPadding(72),
                  left: SizeService.getPadding(52),
                  right: SizeService.getPadding(52),
                  bottom: MediaQuery.of(context).padding.bottom +
                      SizeService.getPadding(52)),
              child: _presenter.listData == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: <Widget>[
                        _titleDetail(),
                        checkRoom == true
                            ? Container(
                                child: _listRoom(),
                                height: height,
                              )
                            : Container(),
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Surgery room : ',
              style: CustomTextTheme.content(context),
            ),
            widget.dataEdit != null
                ? Container(
                    alignment: Alignment.center,
                    width: SizeService.getPadding(180),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff3C95B5),
                      border: Border.all(
                        color: Color(0xff2E363C),
                        width: 0.5,
                      ),
                    ),
                    child: selectRoomName == '' ||
                            selectRoomName.length == 0 ||
                            selectRoomName == null
                        ? Text(
                            '${widget.roomName}',
                            style: CustomTextTheme.linkText(context),
                          )
                        : Text(
                            '${_presenter.operativeRoomCtrl.text}',
                            style: CustomTextTheme.linkText(context),
                          ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        if (checkRoom == true) {
                          checkRoom = false;
                        } else {
                          checkRoom = true;
                        }
                        print(checkRoom);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: SizeService.getPadding(180),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff3C95B5),
                        border: Border.all(
                          color: Color(0xff2E363C),
                          width: 0.5,
                        ),
                      ),
                      child: selectRoomName == '' ||
                              selectRoomName.length == 0 ||
                              selectRoomName == null
                          ? Text(
                              '${widget.roomName}',
                              style: CustomTextTheme.linkText(context),
                            )
                          : Text(
                              '${_presenter.operativeRoomCtrl.text}',
                              style: CustomTextTheme.linkText(context),
                            ),
                    ),
                  ),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _listRoom() {
    return RefreshIndicator(
      key: _presenter.refreshKey,
      onRefresh: _presenter.onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: SizeService.getPadding(64),
          vertical: SizeService.getPadding(80),
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            _presenter.listData.length > 0 ? _presenter.listData.length : 1,
        itemBuilder: (context, index) {
          if (_presenter.listData.length > 0) {
            return _roomItem(_presenter.listData[index]);
          } else {
            return _presenter.loader ? Container() : DataNotFound();
          }
        },
      ),
    );
  }

  Widget _roomItem(SurgeryRoomDataModel data) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeService.getPadding(56)),
      child: MaterialButton(
        padding: EdgeInsets.all(SizeService.getPadding(96)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        onPressed: () {
          setState(() {
            selectRoomID = data.roomId;
            selectRoomName = data.roomName;
            _presenter.operativeRoomCtrl.text = data.roomName;
            _presenter.operativeCode = data.roomId;
            print("roomName=${_presenter.operativeRoomCtrl.text}");
            checkRoom = false;
          });
        },
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              ImageIcon(
                AssetImage('assets/icons/ic_room.png'),
                color: Color(0xff60A8C3),
                size: SizeService.getFontSize(236),
              ),
              SizedBox(width: SizeService.getPadding(52)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Surgery',
                          style: CustomTextTheme.title(context),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            color: Color(0xff60A8C3),
                            size: SizeService.getFontSize(56))
                      ],
                    ),
                    Text(
                      'room',
                      style: CustomTextTheme.title(context).copyWith(
                        height: 1,
                      ),
                    ),
                    Container(
                      width: SizeService.getWidth(30),
                      height: SizeService.getWidth(15),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9900),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Expanded(
                      child: Text(
                        '${data.roomName}',
                        style: CustomTextTheme.title(context)
                            .copyWith(fontSize: SizeService.getFontSize(98)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createForm() {
    return Form(
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
                        padding: EdgeInsets.all(SizeService.getPadding(26)),
                        child: CalendarIcon(),
                      ),
                      validator: Validation.emptyField,
                    ),
                  ),
                ),
              ),
              // _spaceBox,
              // Expanded(
              //   child: Column(
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: SizeService.getPadding(40),
              //           vertical: SizeService.getPadding(34),
              //         ),
              //         margin: EdgeInsets.symmetric(
              //           vertical: SizeService.getPadding(16),
              //         ),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           border: Border.all(
              //             color:
              //                 _presenter.hasStartTime && _presenter.hasEndTime
              //                     ? Color(0xff2E363C)
              //                     : Theme.of(context).errorColor,
              //             width:
              //                 _presenter.hasStartTime && _presenter.hasEndTime
              //                     ? 0.5
              //                     : 1,
              //           ),
              //         ),
              //         child: Row(
              //           children: <Widget>[
              //             Expanded(
              //               child: InkWell(
              //                 onTap: () => _presenter.getTime(0),
              //                 child: Text(
              //                   _presenter.startTimeStr ??
              //                       ResourceString.getString('start'),
              //                   style: TextStyle(
              //                     fontSize: SizeService.getFontSize(35),
              //                     color: _presenter.startTimeStr != null
              //                         ? Color(0xff2E363C)
              //                         : Color(0xff999999),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             Text('| '),
              //             Expanded(
              //               child: InkWell(
              //                 onTap: () => _presenter.getTime(1),
              //                 child: Text(
              //                   _presenter.endTimeStr ??
              //                       ResourceString.getString('end'),
              //                   style: TextStyle(
              //                     fontSize: SizeService.getFontSize(35),
              //                     color: _presenter.endTimeStr != null
              //                         ? Color(0xff2E363C)
              //                         : Color(0xff999999),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       !_presenter.hasStartTime || !_presenter.hasEndTime
              //           ? Text('',
              //               style: TextStyle(
              //                   fontSize: SizeService.getFontSize(42)))
              //           : Container(),
              //     ],
              //   ),
              // ),
            ],
          ),
          _presenter.masterData == null
              ? Container()
              : _dropdown(
                  ResourceString.getString('staff_name'),
                  initValue: _presenter.staffId,
                  onChanged: (v) {
                    setState(() {
                      _presenter.staffId = v;
                    });
                  },
                  validator:
                      _presenter.isEditState ? null : Validation.emptyField,
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
            controller: _presenter.patientNameCtrl,
            hint: ResourceString.getString('patient_name'),
            validator: Validation.emptyField,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: _textField(
                  controller: _presenter.ageCtrl,
                  hint: ResourceString.getString('age'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    // WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  validator: Validation.ageFormat,
                ),
              ),
              // Expanded(
              //   flex: 4,
              //   child: _dropdown(
              //     ResourceString.getString('age'),
              //     initValue: _presenter.ageValue,
              //     onChanged: (v) {
              //       setState(() {
              //         _presenter.ageValue = v;
              //       });
              //     },
              //     items: _presenter.age != null
              //         ? _presenter.age.map((item) {
              //             return DropdownMenuItem(
              //               value: item,
              //               child: Text(
              //                 item.toString(),
              //               ),
              //             );
              //           }).toList()
              //         : null,
              //   ),
              // ),
              _spaceBox,
              Expanded(
                flex: 8,
                child: _textField(
                  controller: _presenter.phoneCtrl,
                  hint: ResourceString.getString('phone'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    // WhitelistingTextInputFormatter.digitsOnly,
                  ],
                  validator: Validation.phoneFormat,
                ),
              ),
            ],
          ),
          _textField(
            controller: _presenter.hnCtrl,
            hint: ResourceString.getString('hn'),
            validator: Validation.emptyField,
            keyboardType: TextInputType.number,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _textField(
                  hint: ResourceString.getString('operative_room'),
                  controller: _presenter.operativeRoomCtrl,
                  enabled: false,
                ),
              ),
              _spaceBox,
              Expanded(
                child: Container(
                  child: _presenter.masterData == null
                      ? Container()
                      : _dropdown(
                          ResourceString.getString('group'),
                          initValue: _presenter.group,
                          fillColor: _presenter.groupColor,
                          onChanged: (v) {
                            print("v => ${v}");
                            var colorHex = _presenter.masterData.group_data
                                .where((w) => w.code == v)
                                .first
                                .color;
                            print(v);
                            setState(() {
                              _presenter.groupColor = HexColor(colorHex);
                              _presenter.group = v;
                            });
                          },
                          items: _presenter.masterData != null
                              ? _presenter.masterData.group_data.map((item) {
                                  return DropdownMenuItem(
                                    value: item.code,
                                    child: Text(
                                      item.name,
                                    ),
                                  );
                                }).toList()
                              : null,
                        ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Expanded(
              //   child: _dropdown(
              //     ResourceString.getString('ordes'),
              //     initValue: _presenter.orderCode,
              //     onChanged: (v) {
              //       setState(() {
              //         _presenter.orderCode = v;
              //       });
              //     },
              //     items: _presenter.masterData != null
              //         ? _presenter.masterData.order_data.map((item) {
              //             return DropdownMenuItem(
              //               value: item.code,
              //               child: Text(
              //                 item.name,
              //               ),
              //             );
              //           }).toList()
              //         : null,
              //   ),
              // ),
              // _spaceBox,
              Expanded(
                child: YesNoInputField(
                  title: ResourceString.getString('anesth'),
                  initialValue: _presenter.asesthStatus,
                  onChanged: (v) {
                    setState(() {
                      print(v);
                      _presenter.onAnesthChanged(v);
                    });
                  },
                ),
              ),
            ],
          ),
          _listTextFile(
            'DX',
            _presenter.dxList,
            _presenter.onDXAdd,
            _presenter.onDXRemove,
          ),
          _listTextFile(
            'OP',
            _presenter.opList,
            _presenter.onOPAdd,
            _presenter.onOPRemove,
          ),
          _listTextFile(
            'Implant',
            _presenter.implantList,
            _presenter.onImplantAdd,
            _presenter.onImplantRemove,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: YesNoInputField(
                  title: ResourceString.getString('vip'),
                  initialValue: _presenter.vipStatus,
                  onChanged: (v) {
                    setState(() {
                      print(v);
                      _presenter.onVIPChanged(v);
                    });
                  },
                ),
              ),
              _spaceBox,
              Expanded(
                child: CustomRadioGroup(
                  initialValue: _presenter.radioValue,
                  onChanged: _presenter.onRadioChanged,
                ),
              ),
            ],
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
        enabled: enabled,
        hintText: hint,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        suffixIcon: suffixIcon,
        maxLine: maxLine,
        minLine: minLine,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _dropdown(
    String name, {
    List<DropdownMenuItem> items,
    Function onChanged,
    dynamic initValue,
    Function validator,
    Color fillColor,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: new CustomDropdown(
        hintText: '$name',
        initialValue: initValue,
        items: items,
        onChanged: onChanged,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        validator: validator,
        fillColor: fillColor,
      ),
    );
  }

  Widget _listTextFile(
      String name, Stream stream, Function onAdd, Function onRemove) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: TextFieldDynamicList(
        title: '$name',
        underLineColor: Color(0xff3C95B5),
        listStream: stream,
        onAdd: onAdd,
        onRemove: onRemove,
      ),
    );
  }
}
