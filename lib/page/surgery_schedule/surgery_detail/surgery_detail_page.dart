import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/environment/base_color.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/environment/resource_string.dart';
import 'package:tuoc/model/surgery/surgery_detail.dart';
import 'package:tuoc/page/surgery_schedule/surgery_detail/surgery_detail_presenter.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/color_util.dart';
import 'package:tuoc/widget/base_container.dart';
import 'package:tuoc/widget/data_not_found.dart';

class SurgeryDetailPage extends StatefulWidget {
  final String roomId;
  final String roomName;
  final String surgeryId;

  SurgeryDetailPage({Key key, this.roomId, this.surgeryId, this.roomName})
      : super(key: key);

  @override
  _SurgeryDetailPageState createState() => _SurgeryDetailPageState();
}

class _SurgeryDetailPageState extends State<SurgeryDetailPage> {
  SurgeryDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = SurgeryDetailPresenter(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      title: ResourceString.getString('schedule_detail'),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
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
                  ? <Widget>[
                      _titleDetail(),
                      _dateTime(_presenter.data[0]),
                      _infoRoom(_presenter.data[0]),
                      _presenter.data[0].dx != null &&
                              _presenter.data[0].dx.length > 0
                          ? _subInfoDetail('DX', _presenter.data[0].dx)
                          : Container(),
                      _presenter.data[0].op != null &&
                              _presenter.data[0].op.length > 0
                          ? _subInfoDetail('OP', _presenter.data[0].op)
                          : Container(),
                      _presenter.data[0].implant != null &&
                              _presenter.data[0].implant.length > 0
                          ? _subInfoDetail(
                              'Implant', _presenter.data[0].implant)
                          : Container(),
                      _presenter.data[0].remark != null &&
                              _presenter.data[0].remark.isNotEmpty
                          ? _subInfoDetail(
                              'Remark', [_presenter.data[0].remark ?? ''])
                          : Container(),
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

  Widget _titleDetail() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Surgery room : ${widget.roomName}',
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
            Row(
              children: <Widget>[
                InkWell(
                  onTap: _presenter.deleteSchedule,
                  child: ImageIcon(
                    AssetImage('assets/icons/ic_bin.png'),
                    size: SizeService.getFontSize(62),
                    color: Color(0xffcccccc),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _dateTime(SurgeryDetailDataModel data) {
    DateTime dateStart = DateTime.parse(data.schedule_start_datetime);
    DateTime dateEnd = DateTime.parse(data.schedule_end_datetime);

    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(46)),
      child: Row(
        children: <Widget>[
          Container(
            width: SizeService.getWidth(15),
            height: SizeService.getHeight(100),
            decoration: BoxDecoration(
              color: data.group_color != null
                  ? HexColor(data.group_color)
                  : BaseColor.surgeryColor(),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: SizeService.getPadding(40)),
          Expanded(child: _dateItem(dateStart, dateEnd))
        ],
      ),
    );
  }

  Widget _dateItem(DateTime dateStart, DateTime dateEnd) {
    var monthFormat = DateFormat('MMM');
    var timeFormat = DateFormat('HH.mm');

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${dateStart.day}',
                style: CustomTextTheme.content(context).copyWith(
                  fontSize: SizeService.getFontSize(65),
                  height: 1,
                ),
              ),
              SizedBox(width: SizeService.getPadding(16)),
              Text(
                '${monthFormat.format(dateStart).toUpperCase()}',
                style: CustomTextTheme.content(context),
              )
            ],
          ),
          // Text(
          //   '${timeFormat.format(dateStart)} - ${timeFormat.format(dateEnd)}',
          //   style: CustomTextTheme.content(context),
          // )
        ],
      ),
    );
  }

  Widget _infoRoom(SurgeryDetailDataModel data) {
    print('${data.anesth_name ?? ''}');
    print('${data.opd_ipd ?? ''}');
    List<Widget> items = [
      _infoRowItem(
          _infoItem('Staff name'), _infoDetailItem('${data.staff_name ?? ''}')),
      _infoRowItem(_infoItem('Patient name'),
          _infoDetailItem('${data.patient_name ?? ''}')),
      _infoRowItem(_infoItem('Age'), _infoDetailItem('${data.age ?? ''}')),
      _infoRowItem(
          _infoItem('Phone'), _infoDetailItem('${data.phone_number ?? ''}')),
      _infoRowItem(_infoItem('HN'), _infoDetailItem('${data.hn ?? ''}')),
      _infoRowItem(_infoItem('Operative room'),
          _infoDetailItem('${data.operative_room_data ?? ''}')),
      _infoRowItem(
          _infoItem('Group'), _infoDetailItem('${data.group_name ?? ''}')),
      // _infoRowItem(
      //     _infoItem('Order'), _infoDetailItem('${data.ordes_name ?? ''}')),
      _infoRowItem(
          _infoItem('Duration'), _infoDetailItem('${data.duration ?? ''}')),
      _infoRowItem(
          _infoItem('Anesth'), _infoDetailItem('${data.anesth_name ?? ''}')),
      _infoRowItem(_infoItem('VIP'), _infoDetailItem('${data.vip_name ?? ''}')),
      _infoRowItem(
          _infoItem('OPD/IPD'), _infoDetailItem('${data.opd_ipd ?? ''}')),
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

  Widget _subInfoDetail(String title, List data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title',
            style: CustomTextTheme.content(context),
          ),
          data != null && data.length > 0
              ? Column(
                  children: data.map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeService.getPadding(16),
                          horizontal: SizeService.getPadding(60)),
                      margin: EdgeInsets.symmetric(
                          vertical: SizeService.getPadding(10)),
                      width: double.maxFinite,
                      color: Color(0xffF2F0F0),
                      child: SelectableText(
                        '$item',
                        style: CustomTextTheme.content(context),
                      ),
                    );
                  }).toList(),
                )
              : Container(),
        ],
      ),
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
