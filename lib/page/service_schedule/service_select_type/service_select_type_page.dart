import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/page/service_schedule/service_create/service_create_page.dart';
import 'package:tuoc/page/service_schedule/service_select_type/service_select_type_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/custom_button.dart';
import 'package:tuoc/widget/custom_dropdown.dart';

class ServiceSelectTypePage extends StatefulWidget {
  final DateTime initialDate;

  ServiceSelectTypePage({Key key, this.initialDate}) : super(key: key);

  @override
  _ServiceSelectTypePageState createState() => _ServiceSelectTypePageState();
}

class _ServiceSelectTypePageState extends State<ServiceSelectTypePage> {
  final List<ServiceCreateType> types = [
    ServiceCreateType.ER,
    ServiceCreateType.OPD,
    ServiceCreateType.OR,
  ];

  String _typeCode = 'SVT-001';

  ServiceSelectTypePresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ServiceSelectTypePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('create_schedule'),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white,
          padding: EdgeInsets.only(
            top: SizeService.getPadding(72),
            left: SizeService.getPadding(52),
            right: SizeService.getPadding(52),
            bottom: MediaQuery.of(context).padding.bottom +
                SizeService.getPadding(52),
          ),
          child: _presenter.masterData == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _content(),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Service Schedule',
                style: CustomTextTheme.content(context),
              ),
              SizedBox(height: SizeService.getPadding(55)),
              Text(
                'Please select type',
                style: TextStyle(
                  color: Color(0xff2E363C),
                  fontSize: SizeService.getFontSize(35),
                ),
              ),
              SizedBox(height: SizeService.getPadding(16)),
              CustomDropdown(
                hintText: 'Type',
                initialValue: _typeCode,
                borderColor: Color(0xff2E363C),
                borderSize: 0.5,
                onChanged: (v) {
                  setState(() {
                    _typeCode = v;
                  });
                },
                items: _presenter.masterData != null
                    ? _presenter.masterData.service_type_data.map((item) {
                        return _dropdownItem(item.name, item.code);
                      }).toList()
                    : null,
              ),
            ],
          ),
          CustomButton(
            onPressed: () {
              var type = ServiceCreateType.ER;

              switch (_typeCode.toUpperCase()) {
                case 'SVT-002':
                  type = ServiceCreateType.ER;
                  break;
                case 'SVT-001':
                  type = ServiceCreateType.OPD;
                  break;
                case 'SVT-003':
                  type = ServiceCreateType.OR;
                  break;
              }

              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ServiceCreatePage(
                    createType: type,
                    initialDate: widget.initialDate,
                    typeCode: _typeCode,
                  ),
                ),
              );
            },
            buttonText: 'Next',
          ),
        ],
      ),
    );
  }

  DropdownMenuItem _dropdownItem(String name, String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(
        '$name',
        style: TextStyle(
          fontSize: SizeService.getFontSize(36),
        ),
      ),
    );
  }
}
