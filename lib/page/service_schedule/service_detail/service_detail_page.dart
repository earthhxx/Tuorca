import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/service/detail/service_detail.dart';
import 'package:tuoc/page/service_schedule/service_detail/service_detail_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';

class ServiceDetailPage extends StatefulWidget {
  final String serviceId;
  final String serviceTypeName;

  ServiceDetailPage({Key key, this.serviceId, this.serviceTypeName})
      : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  ServiceDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = ServiceDetailPresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var info = IntrinsicHeight(child: SizedBox(height: 20));
    if (_presenter != null && _presenter.data.length > 0) {
      switch (widget.serviceTypeName?.toUpperCase()) {
        case "ER":
          info = _infoER(_presenter.data[0]);
          break;
        case "OPD":
          info = _infoOPD(_presenter.data[0]);
          break;
        case "OR":
          info = _infoOR(_presenter.data[0]);
          break;
      }
    }
    return BaseContainer(
      title: ResourceString.getString('service_detail'),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.white,
          child: RefreshIndicator(
            key: _presenter.refreshKey,
            onRefresh: _presenter.onRefresh,
            child: ListView(
              padding: EdgeInsets.only(
                  top: SizeService.getPadding(72),
                  left: SizeService.getPadding(52),
                  right: SizeService.getPadding(52),
                  bottom: MediaQuery.of(context).padding.bottom +
                      SizeService.getPadding(52)),
              children: _presenter.data.length > 0
                  ? [
                      _titleDetail(_presenter.data[0]),
                      _dateTime(_presenter.data[0]),
                      info,
                    ]
                  : _presenter.loader
                      ? [Container()]
                      : [DataNotFound(colorText: Color(0xff2E363C))],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleDetail(ServiceDetailDataModel data) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Service Schedule : ${data.service_type_name}',
            style: CustomTextTheme.content(context),
          ),
        ),
        Row(
          children: <Widget>[
            InkWell(
              onTap: _presenter.gotoEdit,
              child: Icon(Icons.edit,
                  size: SizeService.getFontSize(62), color: Color(0xffcccccc)),
            ),
            SizedBox(width: SizeService.getPadding(36)),
            InkWell(
              onTap: _presenter.onDelete,
              child: ImageIcon(
                AssetImage('assets/icons/ic_bin.png'),
                size: SizeService.getFontSize(62),
                color: Color(0xffcccccc),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateTime(ServiceDetailDataModel data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(46)),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeService.getWidth(15),
            height: SizeService.getHeight(100),
            decoration: BoxDecoration(
              color: BaseColor.serviceColor(),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: SizeService.getPadding(40)),
          Expanded(child: _dateItem(data))
        ],
      ),
    );
  }

  Widget _dateItem(ServiceDetailDataModel data) {
    var monthFormat = DateFormat('MMM');
    var timeFormat = DateFormat('HH.mm');
    var startDate = DateTime.parse(data.schedule_start_datetime);
    var endDate = DateTime.parse(data.schedule_end_datetime);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${startDate.day}',
                style: CustomTextTheme.content(context).copyWith(
                  fontSize: SizeService.getFontSize(65),
                  height: 1,
                ),
              ),
              SizedBox(width: SizeService.getPadding(16)),
              Text(
                '${monthFormat.format(startDate).toUpperCase()}',
                style: CustomTextTheme.content(context),
              )
            ],
          ),
          Text(
            '${timeFormat.format(startDate)} - ${timeFormat.format(endDate)}',
            style: CustomTextTheme.content(context),
          )
        ],
      ),
    );
  }

  Widget _infoER(ServiceDetailDataModel data) {
    List<Widget> items = [
      _infoRowItem(
          _infoItem('Staff name'), _infoDetailItem('${data.staff_name ?? ''}')),
      _infoRowItem(_infoItem('Type'),
          _infoDetailItem('${data.orthopaedic_subspecialties_name ?? ''}')),
      _infoRowItem(_infoItem('R4'), _infoDetailItem('${data.r_4}')),
      _infoRowItem(_infoItem('R3'), _infoDetailItem('${data.r_3}')),
      _infoRowItem(_infoItem('R2'), _infoDetailItem('${data.r_2}')),
      _infoRowItem(_infoItem('R1'), _infoDetailItem('${data.r_1}')),
      _infoRowItem(_infoItem('Intern'), _infoDetailItem('${data.intern}')),
      _infoRowItem(
          _infoItem('ER Daytime'), _infoDetailItem('${data.er_daytime}')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
    ];

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(38)),
        child: Column(
          children: items,
        ),
      ),
    );
  }

  Widget _infoOPD(ServiceDetailDataModel data) {
    List<Widget> items = [
      _infoRowItem(
          _infoItem('Chief R'), _infoDetailItem('${data.chief_r ?? ''}')),
      _infoRowItem(_infoItem('Type'),
          _infoDetailItem('${data.orthopaedic_subspecialties_name ?? ''}')),
      _infoRowItem(_infoItem('R4'), _infoDetailItem('${data.r_4}')),
      _infoRowItem(_infoItem('R3'), _infoDetailItem('${data.r_3}')),
      _infoRowItem(_infoItem('R2'), _infoDetailItem('${data.r_2}')),
      _infoRowItem(_infoItem('R1'), _infoDetailItem('${data.r_1}')),
      _infoRowItem(_infoItem('Intern'), _infoDetailItem('${data.intern}')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
    ];

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(38)),
        child: Column(
          children: items,
        ),
      ),
    );
  }

  Widget _infoOR(ServiceDetailDataModel data) {
    List<Widget> items = [
      _infoRowItem(
          _infoItem('Group'), _infoDetailItem('${data.groups_name ?? ''}')),
      _infoRowItem(
          _infoItem('OR No.'), _infoDetailItem('${data.or_name ?? ''}')),
      _infoRowItem(
          _infoItem('Staff Name'), _infoDetailItem('${data.staff_name}')),
      _infoRowItem(_infoItem('Resident'), _infoDetailItem('${data.resident}')),
      _infoRowItem(_infoItem('Intern'), _infoDetailItem('${data.intern}')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
      _infoRowItem(_infoItem(''), _infoDetailItem('')),
    ];

    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(bottom: SizeService.getPadding(38)),
        child: Column(
          children: items,
        ),
      ),
    );
  }

  Widget _infoItem(String title) {
    return Text(
      title,
      style: CustomTextTheme.content(context),
    );
  }

  Widget _infoDetailItem(String title) {
    return SelectableText(
      title,
      style: CustomTextTheme.content(context),
    );
  }

  Widget _infoRowItem(Widget title, Widget value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: title,
          ),
          Container(
            margin: EdgeInsets.only(right: SizeService.getPadding(58)),
            color: Color(0xffF2F0F0),
            width: SizeService.getWidth(5),
          ),
          Expanded(
            flex: 8,
            child: value,
          ),
        ],
      ),
    );
  }
}
