import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/page/my_schedule/my_edit/my_edit_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/calendar_icon.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_dropdown.dart';
import 'package:tuoc/widget/custom_radio_group.dart';
import 'package:tuoc/widget/custom_textfield.dart';
import 'package:tuoc/widget/text_field_dynamic_list.dart';
import 'package:tuoc/widget/yes_no_input_field.dart';

class MyEditPage extends StatefulWidget {
  MyEditPage({Key key}) : super(key: key);

  @override
  _MyEditPageState createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  MyEditPresenter _presenter;
  double _paddingField = 16;
  Widget _spaceBox = SizedBox(width: SizeService.getPadding(46));

  @override
  void initState() {
    super.initState();

    _presenter = MyEditPresenter(this);
  }

  @override
  void dispose() {
    _presenter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseContainer(
        title: ResourceString.getString('create_schedule'),
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
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Surgery room : ROOM 1',
            style: CustomTextTheme.content(context),
          ),
        ),
      ],
    );
  }

  Widget _createForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _textField(
                  hint: ResourceString.getString('date'),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(SizeService.getPadding(32)),
                    child: CalendarIcon(),
                  ),
                ),
              ),
              _spaceBox,
              Expanded(
                child: Container(),
              ),
            ],
          ),
          _dropdown(ResourceString.getString('staff_name')),
          _textField(
            hint: ResourceString.getString('patient_name'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: _textField(
                  hint: ResourceString.getString('age'),
                ),
              ),
              _spaceBox,
              Expanded(
                flex: 8,
                child: _textField(
                  hint: ResourceString.getString('phone'),
                ),
              ),
            ],
          ),
          _textField(
            hint: ResourceString.getString('hn'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _dropdown(
                  ResourceString.getString('operative_room'),
                ),
              ),
              _spaceBox,
              Expanded(
                child: _dropdown(
                  ResourceString.getString('group'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _textField(
                  hint: ResourceString.getString('order'),
                ),
              ),
              _spaceBox,
              Expanded(
                child: YesNoInputField(
                  title: ResourceString.getString('anesth'),
                  onChanged: _presenter.onAnesthChanged,
                  initialValue: null,
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
            children: <Widget>[
              Expanded(
                child: YesNoInputField(
                  title: ResourceString.getString('vip'),
                  onChanged: _presenter.onAnesthChanged,
                  initialValue: false,
                ),
              ),
              _spaceBox,
              Expanded(
                child: CustomRadioGroup(),
              ),
            ],
          ),
          _textField(
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
              radius: 10,
              buttonText: ResourceString.getString('create_schedule'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    String hint,
    Widget suffixIcon,
    int minLine,
    int maxLine,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: CustomTextField(
        hintText: hint,
        borderColor: Color(0xff2E363C),
        borderSize: 0.5,
        suffixIcon: suffixIcon,
        maxLine: maxLine,
        minLine: minLine,
      ),
    );
  }

  Widget _dropdown(String name) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeService.getPadding(_paddingField)),
      child: CustomDropdown(
        hintText: '$name',
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
